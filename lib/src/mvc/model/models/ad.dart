import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../extensions.dart';
import '../../controller/services.dart';
import '../enums.dart';
import '../models.dart';

Ad jsonToAd(Map<dynamic, dynamic> json) => Ad.fromMap(json);

class Ad with ChangeNotifier {
  String uuid;
  final UserMin author;
  final String title;
  final String content;
  final String location;
  final AdType type;
  final List<CategorySub> subCategories;
  final List<Tag> tags;
  final DateTime createdAt;
  final bool isPromotion;
  final List<ImageProvider<Object>> images;
  final List<String> imagesUrl;
  final List<XFile> imagesFile;
  final int likes;

  Ad({
    required this.uuid,
    required this.author,
    required this.title,
    required this.content,
    required this.location,
    required this.type,
    required this.subCategories,
    required this.tags,
    required this.createdAt,
    required this.isPromotion,
    required this.images,
    required this.imagesUrl,
    required this.imagesFile,
    required this.likes,
  });

  factory Ad.init({
    required UserSession userSession,
    required String title,
    required String content,
    required String location,
    required List<CategorySub> subCategories,
    required AdType adType,
    required List<Tag> tags,
    required List<XFile> imagesFile,
  }) =>
      Ad(
        uuid: '',
        author: userSession.toUserMin,
        title: title,
        content: content,
        location: location,
        subCategories: subCategories,
        type: adType,
        tags: tags,
        createdAt: DateTime.now(),
        isPromotion: false,
        images: [],
        imagesUrl: [],
        imagesFile: imagesFile,
        likes: 0,
      );

  factory Ad.fromMap(Map<dynamic, dynamic> json) => Ad(
        uuid: json['uuid'],
        author: (json['author'] as Map<dynamic, dynamic>).toUserMin,
        title: json['title'],
        content: json['content'],
        location: json['location'],
        subCategories: List.from(json['subCategory'])
            .map((json) => CategorySub.fromMap(json))
            .toList(),
        type: (json['type'] as String).toAdType,
        tags: List.from(json['tags']).map((e) => Tag.fromMap(e)).toList(),
        createdAt: DateTime.parse(json['created_at']),
        isPromotion: json['isPromotion'],
        images: List.from(json['images'] ?? [])
            .map((e) => CachedNetworkImageProvider(e))
            .toList(),
        imagesUrl: List.from(json['images'] ?? []),
        imagesFile: [],
        likes: json['likes'] ?? 0,
      );

  void updateWithAd(Ad ad) {
    uuid = ad.uuid;
    images.clear();
    images.addAll(ad.images);
    imagesUrl.clear();
    imagesUrl.addAll(ad.imagesUrl);
    imagesFile.clear();
    notifyListeners();
  }

  Map<dynamic, dynamic> get toMapInit => {
        'title': title,
        'content': content,
        'subCategory': subCategories.map((e) => e.name).toList(),
        'location': location,
        'type': type.key,
        'tags': tags.map((e) => e.id).toList(),
        'isPromotion': false,
        'video': 'h',
      };

  static Ad fromResponse(String body) => Ad.fromMap(jsonDecode(body));

  Future<void> markVisited(UserSession userSession) async =>
      AdServices.of(userSession).markAsVisited(this);
}
