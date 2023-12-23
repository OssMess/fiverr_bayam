import 'dart:convert';

import 'package:flutter/material.dart';

import '../../controller/services.dart';
import '../models.dart';

class Category with ChangeNotifier {
  final String uuid;
  String name;
  String description;

  Category({
    required this.uuid,
    required this.name,
    required this.description,
  });

  factory Category.fromMap(Map<dynamic, dynamic> json) => Category(
        uuid: json['uuid'],
        name: json['name'],
        description: json['description'],
      );

  static Category fromResponse(String body) =>
      Category.fromMap(jsonDecode(body));

  Future<void> update({
    required UserSession userSession,
    required String name,
    required String description,
  }) async {
    this.name = name;
    this.description = description;
    await CategoriesServices.of(userSession).update(this);
    notifyListeners();
  }
}
