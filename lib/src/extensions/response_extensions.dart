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

  UserMin get toUserMin => UserMin.fromResponse(body);

  Tag get toTag => Tag.fromResponse(body);

  Plan get toPlan => Plan.fromResponse(body);

  Country get toCountry => Country.fromResponse(body);

  City get toCity => City.fromResponse(body);

  AdComment get toAdComment => AdComment.fromResponse(body);

  Discussion toDiscussion(UserSession userSession) =>
      Discussion.fromResponse(body, userSession);

  Message toMessage(String? discussionId, String uid) => Message.fromResponse(
        body,
        discussionId,
        uid,
      );
}
