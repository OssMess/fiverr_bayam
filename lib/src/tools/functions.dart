import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import '../mvc/model/models.dart';
import 'permissions.dart';

class Functions {
  final BuildContext context;

  Functions(this.context);

  static Functions of(BuildContext context) {
    assert(context.mounted);
    return Functions(context);
  }

  /// translate [key] into a value.
  String translateKey(String key) {
    Map<String, String> translation = {
      'en': AppLocalizations.of(context)!.en,
      'fr': AppLocalizations.of(context)!.fr,
      'person': AppLocalizations.of(context)!.person,
      'company': AppLocalizations.of(context)!.company,
    };
    return translation[key] ?? key;
  }

  static Exception throwExceptionFromResponse(
    UserSession userSession,
    Response response, [
    Map<int, String>? errorMap,
  ]) {
    Map<dynamic, dynamic> body = jsonDecode(response.body);
    log('${response.statusCode}:${body['message']}');
    if ((body['message'] ?? '').contains('Ce post n\'existe pas')) {
      return BackendException(code: 'post-not-found', statusCode: 404);
    }
    if ((body['message'] ?? '').contains('Cannot find User with code')) {
      throw BackendException(code: 'wrong-otp', statusCode: 404);
    }
    Map<int, String> statusCodesPhrases = {
      400: 'invalid-input',
      403: 'unauthorized',
      422: 'unprocessable-entity',
      500: 'internal-server-error',
    };
    if (errorMap != null) statusCodesPhrases.addAll(errorMap);
    if (response.statusCode == 403) {
      Future.delayed(
        const Duration(milliseconds: 100),
        userSession.onSignout,
      );
    }
    return BackendException(
      code: statusCodesPhrases[response.statusCode],
      statusCode: response.statusCode,
    );
  }

  /// translate [exception] into a message.
  String translateException(BackendException exception) {
    Map<String, String> translation = {
      'invalid-input': AppLocalizations.of(context)!.invalid_input,
      'unprocessable-entity':
          AppLocalizations.of(context)!.unprocessable_entity,
      'internal-server-error':
          AppLocalizations.of(context)!.internal_server_error,
      'resource-not-found': AppLocalizations.of(context)!.resource_not_found,
      'unauthorized': AppLocalizations.of(context)!.unauthorized,
      'user-not-found': AppLocalizations.of(context)!.user_not_found,
      'unique-register-number':
          AppLocalizations.of(context)!.unique_register_number,
      'unknown-location': AppLocalizations.of(context)!.location_not_found,
      'wrong-otp': AppLocalizations.of(context)!.wrong_otp,
      'post-not-found': AppLocalizations.of(context)!.post_not_found,
    };
    return translation[exception.code] ??
        AppLocalizations.of(context)!.unknown_error;
  }

  ///Merge two iterables [a] and [b] into one. Mainly used to create a `TextSpam`
  ///for `RichText` widget from the result, after splitting a String and applying the appropriate text style on the matches of a RegExp.
  static Iterable<T> zip<T>(Iterable<T> a, Iterable<T> b) sync* {
    final ita = a.iterator;
    final itb = b.iterator;
    bool hasa, hasb;
    while ((hasa = ita.moveNext()) | (hasb = itb.moveNext())) {
      if (hasa) yield ita.current;
      if (hasb) yield itb.current;
    }
  }

  Future<void> pickMultiImage({
    required void Function(List<XFile>) onPick,
  }) async {
    if (context.mounted &&
        await Permissions.of(context).showPhotoLibraryPermission()) {
      return;
    }
    return await ImagePicker()
        .pickMultiImage(
      maxHeight: 1080,
      maxWidth: 1080,
      imageQuality: 80,
    )
        .then(
      (xfiles) {
        if (xfiles.isEmpty) return;
        onPick(xfiles);
      },
    );
  }

  Future<void> pickImage({
    required ImageSource source,
    required void Function(XFile) onPick,
  }) async {
    if (!context.mounted) return;
    if ((kDebugMode && Platform.isIOS) &&
        source == ImageSource.camera &&
        await Permissions.of(context).showCameraPermission()) {
      return;
    }
    if (source == ImageSource.gallery &&
        // ignore: use_build_context_synchronously
        await Permissions.of(context).showPhotoLibraryPermission()) {
      return;
    }
    return await ImagePicker()
        .pickImage(
      source: kDebugMode && Platform.isIOS ? ImageSource.gallery : source,
      maxHeight: 1080,
      maxWidth: 1080,
      imageQuality: 80,
    )
        .then(
      (xfile) {
        if (xfile == null) return;
        onPick(xfile);
      },
    );
  }
}
