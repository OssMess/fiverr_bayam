import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    };
    return translation[key] ?? key;
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
}
