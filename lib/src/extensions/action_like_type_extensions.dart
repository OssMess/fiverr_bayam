import '../mvc/model/enums.dart';

extension ActionLikeTypeExtensions on ActionLikeType {
  String get key => {
        ActionLikeType.like: 'LIKE',
        ActionLikeType.dislike: 'DISLIKE',
      }[this]!;
}
