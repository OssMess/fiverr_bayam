import 'dart:convert';

import 'package:flutter/material.dart';

import '../../controller/services.dart';
import 'user_session.dart';

class CategorySub with ChangeNotifier {
  final String uuid;
  String name;
  String description;
  String categoryId;

  CategorySub({
    required this.uuid,
    required this.name,
    required this.description,
    required this.categoryId,
  });

  factory CategorySub.fromMap(Map<dynamic, dynamic> json) => CategorySub(
        uuid: json['uuid'] ?? json['id'],
        name: json['name'],
        description: json['description'],
        categoryId: json['preferenceCategory']?['@id'] ?? json['@id'],
      );

  static CategorySub fromResponse(String body) =>
      CategorySub.fromMap(jsonDecode(body));

  Future<void> update({
    required UserSession userSession,
    required String name,
    required String description,
  }) async {
    this.name = name;
    this.description = description;
    await CategoriesSubServices.of(userSession).update(this);
    notifyListeners();
  }
}
