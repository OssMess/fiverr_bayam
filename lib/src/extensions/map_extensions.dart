import '../mvc/model/models.dart';

extension Mapextensions on Map<dynamic, dynamic> {
  Ad toAd(UserSession userSession) => Ad.fromAd(this, userSession);

  AdPromoted get toAdPromoted => AdPromoted.fromMap(this);

  Author get toAuthor => Author.fromMap(this);

  UserMin get toUserMin => UserMin.fromMap(this);

  Category get toCategory => Category.fromMap(this);

  CategorySub get toCategorySub => CategorySub.fromMap(this);

  Chat get toChat => Chat.fromMap(this);

  Tag get toTag => Tag.fromMap(this);

  Plan get toPlan => Plan.fromMap(this);

  Country get toCountry => Country.fromMap(this);

  City get toCity => City.fromMap(this);

  AdComment get toAdComment => AdComment.fromMap(this);

  Discussion toDiscussion(UserSession userSession) =>
      Discussion.fromMap(this, userSession);

  Message toMessage(String? discussionId, String uid) =>
      Message.fromMap(this, discussionId, uid);
}
