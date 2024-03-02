import 'package:bayam/src/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models.dart';

class SearchHistory {
  final String id;
  final CategorySub categorySub;
  final String? displayName;
  final ImageProvider<Object>? image;
  final String? imageUrl;

  SearchHistory({
    required this.id,
    required this.categorySub,
    required this.displayName,
    required this.image,
    required this.imageUrl,
  });

  factory SearchHistory.fromUserMin(
    UserMin userMin,
    CategorySub categorySub,
  ) =>
      SearchHistory(
        id: userMin.uid,
        categorySub: categorySub,
        displayName: userMin.displayName,
        image: userMin.imageProfile,
        imageUrl: userMin.imageProfileUrl,
      );

  factory SearchHistory.fromAd(
    Ad ad,
  ) =>
      SearchHistory(
        id: ad.uuid,
        categorySub: ad.subCategories.first,
        displayName: ad.author.displayName,
        image: ad.author.imageProfile,
        imageUrl: ad.author.imageProfileUrl,
      );

  factory SearchHistory.fromMap(Map<dynamic, dynamic> json) => SearchHistory(
        id: json['id'],
        categorySub: (json['categorySub'] as Map).toCategorySub,
        displayName: json['displayName'],
        image: json['imageUrl'] != null
            ? CachedNetworkImageProvider(json['imageUrl'])
            : null,
        imageUrl: json['imageUrl'],
      );

  Map<dynamic, dynamic> get toMapInit => {
        'id': id,
        'categorySub': categorySub.toMapInit,
        'displayName': displayName,
        'imageUrl': imageUrl,
      };
}
