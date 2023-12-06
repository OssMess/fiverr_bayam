import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../extensions.dart';
import '../enums.dart';
import '../models.dart';

Ad jsonToAd(Map<dynamic, dynamic> json) => Ad.fromMap(json);

class Ad with ChangeNotifier {
  final String uuid;
  final Author author;
  final String title;
  final String content;
  final String location;
  final AdType type;
  final AdCategory category;
  final List<Tag> tags;
  final DateTime createdAt;
  final bool isPromotion;
  final List<dynamic> promotions;
  //TODO
  final int likes;
  final String coverPhotoUrl;

  Ad({
    required this.uuid,
    required this.author,
    required this.title,
    required this.content,
    required this.location,
    required this.type,
    required this.category,
    required this.tags,
    required this.createdAt,
    required this.isPromotion,
    required this.promotions,
    required this.likes,
    required this.coverPhotoUrl,
  });

  factory Ad.init({
    required UserSession user,
    required String title,
    required String content,
    required String location,
    required AdType adType,
    required AdCategory category,
    required List<Tag> tags,
  }) =>
      Ad(
        uuid: '',
        author: user.toAuthor,
        title: title,
        content: content,
        location: location,
        category: category,
        type: adType,
        tags: tags,
        createdAt: DateTime.now(),
        isPromotion: false,
        promotions: [],
        likes: 0,
        coverPhotoUrl: '',
      );

  factory Ad.fromMap(Map<dynamic, dynamic> json) => Ad(
        uuid: json['uuid'],
        author: (json['author'] as Map<dynamic, dynamic>).toAuthor,
        title: json['title'],
        content: json['content'],
        location: json['location'],
        category: (json['category'] as String).toCategory,
        type: (json['type'] as String).toAdType,
        tags: List.from(json['tags']).map((e) => Tag.fromMap(e)).toList(),
        createdAt: DateTime.parse(json['created_at']),
        isPromotion: json['isPromotion'],
        promotions: List.from(json['promotions']),
        //TODO add likes, cover photo url, isLiked
        likes: 0,
        coverPhotoUrl: '',
      );

  Map<dynamic, dynamic> get toMapInit => {
        // 'author': author.uid,
        'title': title,
        'content': content,
        'category': category.key,
        'location': location,
        'type': type.key,
        'tags': tags.map((e) => e.name).toList(),
        'isPromotion': false,
        'video': 'h',
      };

  static Ad fromResponse(String response) => Ad.fromMap(jsonDecode(response));
}
