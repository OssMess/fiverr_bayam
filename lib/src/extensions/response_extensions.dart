import 'package:http/http.dart';

import '../mvc/model/models.dart';

extension ResponseExtensions on Response {
  Ad get toAd => Ad.fromResponse(body);

  AdPromoted get toAdPromoted => AdPromoted.fromResponse(body);

  Category get toCategory => Category.fromResponse(body);

  CategorySub get toCategorySub => CategorySub.fromResponse(body);

  Chat get toChat => Chat.fromResponse(body);

  UserMin get toUserMin => UserMin.fromResponse(body);

  Tag get toTag => Tag.fromResponse(body);

  Discussion toDiscussion(UserSession userSession) =>
      Discussion.fromResponse(body, userSession);

  Message toMessage(String? discussionId, String uid) => Message.fromResponse(
        body,
        discussionId,
        uid,
      );
}
