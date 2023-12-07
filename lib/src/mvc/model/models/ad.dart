import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
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
  final Category category;
  final List<Tag> tags;
  final DateTime createdAt;
  final bool isPromotion;
  final List<ImageProvider<Object>> images;
  final List<String> imagesUrl;
  final int likes;

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
    required this.images,
    required this.imagesUrl,
    required this.likes,
  });

  factory Ad.fromMap(Map<dynamic, dynamic> json) => Ad(
        uuid: json['uuid'],
        author: (json['author'] as Map<dynamic, dynamic>).toAuthor,
        title: json['title'],
        content: json['content'],
        location: json['location'],
        category: Category.fromJson(json['category']),
        type: (json['type'] as String).toAdType,
        tags: List.from(json['tags']).map((e) => Tag.fromMap(e)).toList(),
        createdAt: DateTime.parse(json['created_at']),
        isPromotion: json['isPromotion'],
        images: List.from(json['images'] ?? [])
            .map((e) => CachedNetworkImageProvider(e))
            .toList(),
        imagesUrl: List.from(json['images'] ?? []),
        likes: json['likes'] ?? 0,
      );

  Map<dynamic, dynamic> get toMapInit => {
        // 'author': author.uid,
        'title': title,
        'content': content,
        'category': category.uuid,
        'location': location,
        'type': type.key,
        'tags': tags.map((e) => e.name).toList(),
        'isPromotion': false,
        'video': 'h',
      };

  static Ad fromResponse(String response) => Ad.fromMap(jsonDecode(response));
}
