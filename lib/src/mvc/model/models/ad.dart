import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../extensions.dart';
import '../../controller/services.dart';
import '../enums.dart';
import '../list_models.dart';
import '../models.dart';

Ad jsonToAd(
  Map<dynamic, dynamic> json,
  UserSession userSession,
) =>
    Ad.fromMapGet(json, userSession);

class Ad with ChangeNotifier {
  String uuid;
  final bool isMine;
  final UserMin author;
  final String title;
  String content;
  String location;
  AdType type;
  List<CategorySub> subCategories;
  List<Tag> tags;
  final DateTime createdAt;
  final bool isPromotion;
  List<ImageProvider<Object>> images;
  List<String> imagesUrl;
  List<XFile> imagesFile;
  int likes;
  ListAdComments listAdComments;

  Ad({
    required this.uuid,
    required this.isMine,
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
    required this.listAdComments,
  });

  int get imagesCount => imagesUrl.length;

  factory Ad.init({
    required String? uuid,
    required UserSession userSession,
    required String title,
    required String content,
    required String location,
    required List<CategorySub> subCategories,
    required AdType type,
    required List<Tag> tags,
    required List<XFile> imagesFile,
    required List<String> imagesUrl,
  }) =>
      Ad(
        uuid: uuid ?? '',
        isMine: true,
        author: userSession.toUserMin,
        title: title,
        content: content,
        location: location,
        subCategories: subCategories,
        type: type,
        tags: tags,
        createdAt: DateTime.now(),
        isPromotion: false,
        images: [],
        imagesUrl: imagesUrl,
        imagesFile: imagesFile,
        likes: 0,
        listAdComments: ListAdComments(userSession: userSession, adId: ''),
      );

  factory Ad.fromMapPost(
    Map<dynamic, dynamic> json,
    UserSession userSession,
  ) =>
      Ad(
        uuid: json['uuid'],
        isMine: json['author']['uuid'] == userSession.uid,
        author:
            (json['author'] as Map<dynamic, dynamic>).toUserMin(userSession),
        title: json['title'],
        content: json['content'],
        location: json['location'],
        subCategories: List.from(json['subCategory'])
            .map((json) => CategorySub.fromMap(json))
            .toList(),
        type: (json['type'] as String).toAdType,
        tags: List.from(json['tags']).map((e) => Tag.fromMap(e)).toList(),
        createdAt: DateTime.parse(json['created_at']),
        isPromotion: json['isAds'],
        images: List.from(json['images'] ?? [])
            .map((e) => CachedNetworkImageProvider(e))
            .toList(),
        imagesUrl: List.from(json['images'] ?? []),
        imagesFile: [],
        likes: json['likes'] ?? 0,
        listAdComments: ListAdComments(
          userSession: userSession,
          adId: json['uuid'],
        ),
      );

  factory Ad.fromMapGet(
    Map<dynamic, dynamic> json,
    UserSession userSession,
  ) =>
      Ad(
        uuid: json['post']['uuid'],
        isMine:
            (json['user'] ?? json['post']['author'])['uuid'] == userSession.uid,
        author:
            ((json['user'] ?? json['post']['author']) as Map<dynamic, dynamic>)
                .toUserMin(userSession),
        title: json['post']['title'],
        content: json['post']['content'],
        location: json['post']['location'],
        subCategories: List.from(json['post']['subCategory'])
            .map((json) => CategorySub.fromMap(json))
            .toList(),
        type: (json['post']['type'] as String).toAdType,
        tags:
            List.from(json['post']['tags']).map((e) => Tag.fromMap(e)).toList(),
        createdAt: DateTime.parse(json['created_at']),
        isPromotion: json['post']['isAds'],
        images: List.from(json['post']['images'] ?? [])
            .map((e) => CachedNetworkImageProvider(e))
            .toList(),
        imagesUrl: List.from(json['post']['images'] ?? []),
        imagesFile: [],
        likes: json['post']['likeNumber'] ?? 0,
        listAdComments: ListAdComments(
          userSession: userSession,
          adId: json['uuid'],
        ),
      );

  void updateWithAd(
    Ad ad,
  ) {
    images.clear();
    images.addAll(ad.images);
    imagesUrl.clear();
    imagesUrl.addAll(ad.imagesUrl);
    imagesFile.clear();
    content = ad.content;
    location = ad.location;
    type = ad.type;
    subCategories = ad.subCategories;
    tags = ad.tags;
    notifyListeners();
  }

  Map<dynamic, dynamic> get toMapInit => {
        'title': title,
        'content': content,
        'subCategory': subCategories.map((e) => e.uuid).toList(),
        'location': location,
        'type': type.key,
        'tags': tags.map((e) => e.name).toList(),
        'isAds': false,
        // 'video': 'h',
      };

  static Ad fromResponse(
    String body,
    UserSession userSession,
  ) =>
      Ad.fromMapGet(
        jsonDecode(body),
        userSession,
      );

  static Ad fromResponsePost(
    String body,
    UserSession userSession,
  ) =>
      Ad.fromMapPost(
        jsonDecode(body),
        userSession,
      );

  Future<void> markVisited(UserSession userSession) async =>
      AdServices.of(userSession).markAsVisited(this);

  Future<void> like(UserSession userSession) async {
    AdServices.of(userSession).like(this);
    likes++;
    notifyListeners();
  }

  Future<void> delete(UserSession userSession) async {
    await AdServices.of(userSession).delete(this);
    userSession.listAdsMy!.remove(this);
  }

  Future<void> comment(UserSession userSession, String comment) async {
    AdComment adComment = await AdServices.of(userSession).comment(
      this,
      comment,
    );
    listAdComments.insert(adComment);
  }

  Future<void> addToFavorites(UserSession userSession) async {
    await FavoritesServices.of(userSession).post(uuid);
  }
}
