import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../extensions.dart';

class Message2 with ChangeNotifier {
  final String senderId;
  final String senderAvatarUrl;
  final ImageProvider<Object> senderAvatar;
  final String? message;
  final ImageProvider<Object>? photo;
  String? photoUrl;
  String? audioUrl;
  final double? aspectRatio;
  final DateTime createdAt;
  final bool isMine;
  bool isSending;
  bool hasError;

  Message2({
    required this.senderId,
    required this.senderAvatarUrl,
    required this.senderAvatar,
    required this.message,
    required this.photo,
    required this.photoUrl,
    required this.audioUrl,
    required this.aspectRatio,
    required this.createdAt,
    required this.isMine,
    this.isSending = false,
    this.hasError = false,
  });

  factory Message2.fromJson(Map<String, dynamic> json) {
    return Message2(
      senderId: json['senderId'],
      senderAvatarUrl: json['senderAvatarUrl'],
      senderAvatar: CachedNetworkImageProvider(json['senderAvatarUrl']),
      message: json['message'],
      createdAt: json['createdAt'],
      photo: json['photoUrl'] != null
          ? (json['photoUrl'].startsWith('https://')
              ? CachedNetworkImageProvider(
                  json['photoUrl'],
                )
              : Image.file(File(json['photoUrl'])).image)
          : null,
      photoUrl: json['photoUrl'],
      audioUrl: json['audioUrl'],
      aspectRatio: json['aspectRatio'],
      isMine: json['senderId'] == 'myid',
      isSending: json['isSending'],
    );
  }

  bool get isText => message.isNotNull;

  bool get isNotText => message.isNull;

  bool get isImage => message.isNull && photoUrl.isNotNull;

  bool get isAudio => message.isNull && audioUrl.isNotNull;
}
