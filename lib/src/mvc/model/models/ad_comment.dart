import 'dart:convert';

import '../../../extensions.dart';
import '../models.dart';

AdComment jsonToAdComment(Map<dynamic, dynamic> json) =>
    AdComment.fromMap(json);

class AdComment {
  final UserMin author;
  final String post;
  final String uuid;
  final String createdAt;
  final String updatedAt;
  final String content;
  final String isValid;

  AdComment({
    required this.author,
    required this.post,
    required this.uuid,
    required this.createdAt,
    required this.updatedAt,
    required this.content,
    required this.isValid,
  });

  factory AdComment.fromMap(Map<dynamic, dynamic> json) => AdComment(
        author: (json['author'] as Map<dynamic, dynamic>).toUserMin,
        post: json['post'],
        uuid: json['uuid'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        content: json['content'],
        isValid: json['isValid'],
      );

  Map<String, dynamic> get toMap => {
        'author': author.uid,
        'post': post,
        'uuid': uuid,
        'content': content,
        'isValid': isValid,
      };

  static AdComment fromResponse(String body) =>
      AdComment.fromMap(jsonDecode(body));
}
