import 'package:http/http.dart';

import '../mvc/model/models.dart';

extension ResponseExtensions on Response {
  Ad toAd(UserSession userSession) => Ad.fromResponse(body, userSession);

  Ad toAdPost(UserSession userSession) =>
      Ad.fromResponsePost(body, userSession);

  AdPromoted toAdPromoted(UserSession userSession) => AdPromoted.fromResponse(
        body,
        userSession,
      );

  Category get toCategory => Category.fromResponse(body);

  CategorySub get toCategorySub => CategorySub.fromResponse(body);

  Chat get toChat => Chat.fromResponse(body);

  UserMin toUserMin(UserSession userSession) => UserMin.fromResponse(
        body,
        userSession,
      );

  Tag get toTag => Tag.fromResponse(body);

  Plan get toPlan => Plan.fromResponse(body);

  Country get toCountry => Country.fromResponse(body);

  City get toCity => City.fromResponse(body);

  AdComment toAdComment(UserSession userSession) => AdComment.fromResponse(
        body,
        userSession,
      );

  Discussion toDiscussion(UserSession userSession) =>
      Discussion.fromResponse(body, userSession);

  Message toMessage(String? discussionId, String uid) => Message.fromResponse(
        body,
        discussionId,
        uid,
      );
}
