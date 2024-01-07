import 'package:bayam/src/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models.dart';

class SearchHistory {
  final CategorySub categorySub;
  final String? displayName;
  final ImageProvider<Object>? image;
  final String? imageUrl;

  SearchHistory({
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
        categorySub: categorySub,
        displayName: userMin.displayName,
        image: userMin.imageProfile,
        imageUrl: userMin.imageProfileUrl,
      );

  factory SearchHistory.fromMap(Map<dynamic, dynamic> json) => SearchHistory(
        categorySub: (json['categorySub'] as Map).toCategorySub,
        displayName: json['displayName'],
        image: json['imageUrl'] != null
            ? CachedNetworkImageProvider(json['imageUrl'])
            : null,
        imageUrl: json['imageUrl'],
      );

  Map<dynamic, dynamic> get toMapInit => {
        'categorySub': categorySub.toMapInit,
        'displayName': displayName,
        'imageUrl': imageUrl,
      };
}
