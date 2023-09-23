import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Message with ChangeNotifier {
  final String senderId;
  final String senderAvatarUrl;
  final ImageProvider<Object> senderAvatar;
  final String? message;
  final ImageProvider<Object>? photo;
  String? photoUrl;
  final double? aspectRatio;
  final DateTime createdAt;
  final bool isMine;
  bool isSending;
  bool hasError;

  Message({
    required this.senderId,
    required this.senderAvatarUrl,
    required this.senderAvatar,
    required this.message,
    required this.photo,
    required this.photoUrl,
    required this.aspectRatio,
    required this.createdAt,
    required this.isMine,
    this.isSending = false,
    this.hasError = false,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['senderId'],
      senderAvatarUrl: json['senderAvatarUrl'],
      senderAvatar: CachedNetworkImageProvider(json['senderAvatarUrl']),
      message: json['message'],
      createdAt: json['createdAt'],
      photo: json['photoUrl'] != null
          ? CachedNetworkImageProvider(json['photoUrl'])
          : null,
      photoUrl: json['photoUrl'],
      aspectRatio: json['aspectRatio'],
      isMine: json['senderId'] == 'myid',
      isSending: json['isSending'],
    );
  }

  bool get isText => message != null;

  bool get isImage => message == null && photo != null;
}
