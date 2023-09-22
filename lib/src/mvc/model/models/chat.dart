import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Chat {
  final String displayName;
  final String photoUrl;
  final ImageProvider<Object> photo;
  final bool seen;
  final bool isOnline;
  final String lastMessage;
  final DateTime updatedAt;

  Chat({
    required this.displayName,
    required this.photoUrl,
    required this.photo,
    required this.seen,
    required this.isOnline,
    required this.lastMessage,
    required this.updatedAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        displayName: json['displayName'],
        photoUrl: json['photoUrl'],
        photo: CachedNetworkImageProvider(json['photoUrl']),
        seen: json['seen'],
        isOnline: json['isOnline'],
        lastMessage: json['lastMessage'],
        updatedAt: json['updatedAt'],
      );
}
