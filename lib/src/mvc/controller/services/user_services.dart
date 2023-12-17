import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../extensions.dart';
import '../../../tools.dart';
import '../../model/models.dart';
import '../services.dart';

class UserServices {
  static const String baseUrl = 'https://api.bayam.site';

  final UserSession userSession;

  UserServices(this.userSession);

  static UserServices of(UserSession userSession) {
    return UserServices(userSession);
  }

  /// Get user details and reffresh user session with `onSignInCompleted`.
  Future<void> get() async {
    var request = http.Request(
      'GET',
      Uri.parse(
        '$baseUrl/api/user/me',
      ),
    );
    request.headers.addAll(Services.headersldJson);
    http.Response response = await HttpRequest.attemptHttpCall(request);
    if (response.statusCode == 200) {
      userSession.onSignInCompleted(
        jsonDecode(
          response.body,
        ),
      );
    } else {
      throw Functions.throwExceptionFromResponse(userSession, response);
    }
  }

  /// Update user details with current values, as well as [imageProfile],
  /// [imageCompany],[imageCompanyTax], and [imageUserIdentity].
  Future<void> post({
    File? imageProfile,
    File? imageCompany,
    List<File>? imageCompanyTax,
    List<File>? imageUserIdentity,
  }) async {
    var request = http.Request(
      'PATCH',
      Uri.parse(
        '$baseUrl/api/users',
      ),
    );
    request.headers.addAll({
      HttpHeaders.contentTypeHeader: 'application/merge-patch+json',
      ...Services.headerAcceptldJson,
    });
    var body = {
      'isCompanyOrClient': true,
      'isVerified': false,
      'phoneNumber': userSession.phoneNumber,
      if (userSession.firstName.isNotNullOrEmpty)
        'firstName': userSession.firstName,
      if (userSession.lastName.isNotNullOrEmpty)
        'lastName': userSession.lastName,
      if (userSession.email.isNotNullOrEmpty) 'email': userSession.email,
      if (userSession.birthDate.isNotNullOrEmpty)
        'birthdate': userSession.birthDate,
      if (userSession.city.isNotNullOrEmpty) 'city': userSession.city,
      if (userSession.bio.isNotNullOrEmpty) 'bio': userSession.bio,
      if (userSession.streetAddress.isNotNullOrEmpty)
        'streetAddress': userSession.streetAddress,
      if (userSession.postalCode.isNotNullOrEmpty)
        'postalCode': userSession.postalCode,
      if (userSession.region.isNotNullOrEmpty) 'region': userSession.region,
      'country': userSession.country,
      if (userSession.companyName.isNotNullOrEmpty)
        'companyName': userSession.companyName,
      if (userSession.facebookUrl.isNotNullOrEmpty)
        'facebookUrl': userSession.facebookUrl,
      if (userSession.linkedinUrl.isNotNullOrEmpty)
        'linkedinUrl': userSession.linkedinUrl,
      if (userSession.twitterUrl.isNotNullOrEmpty)
        'twitterUrl': userSession.twitterUrl,
      if (userSession.uniqueRegisterNumber.isNotNullOrEmpty)
        'uniqueRegisterNumber': userSession.uniqueRegisterNumber,
      'preferenceList': userSession.preferences ?? [],
    };
    if (imageProfile != null) {
      await imageProfile.toBase64String().then((value) => body.addAll({
            'imageProfile': value,
          }));
    }
    if (imageCompany != null) {
      await imageCompany.toBase64String().then((value) => body.addAll({
            'imageCompany': [value],
          }));
    }
    if (imageCompanyTax != null) {
      List<String> imagesCompanyTaxt = [];
      for (var image in imageCompanyTax) {
        await image
            .toBase64String()
            .then((value) => imagesCompanyTaxt.add(value));
      }
      body.addAll({
        'imageCompanyTax': imagesCompanyTaxt,
      });
    }
    if (imageUserIdentity != null) {
      List<String> imagesUserIdentity = [];
      for (var image in imageUserIdentity) {
        await image
            .toBase64String()
            .then((value) => imagesUserIdentity.add(value));
      }
      body.addAll({
        'imageUserIdentity': imagesUserIdentity,
      });
    }
    request.body = json.encode(body);
    http.Response response = await HttpRequest.attemptHttpCall(
      request,
      retries: 0,
      timeout: const Duration(seconds: 100),
    );
    if (response.statusCode == 200) {
      userSession.onSignInCompleted(
        jsonDecode(
          response.body,
        ),
      );
    } else {
      throw Functions.throwExceptionFromResponse(
        userSession,
        response,
        response.body.contains('unique_register_number')
            ? {
                response.statusCode: 'unique-register-number',
              }
            : null,
      );
    }
  }
}
