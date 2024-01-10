import '../mvc/model/models.dart';

extension Mapextensions on Map<dynamic, dynamic> {
  Ad toAdGet(UserSession userSession) => Ad.fromMapGet(this, userSession);

  Ad toAdPost(UserSession userSession) => Ad.fromMapPost(this, userSession);

  AdPromoted toAdPromoted(UserSession userSession) => AdPromoted.fromMap(
        this,
        userSession,
      );

  Author get toAuthor => Author.fromMap(this);

  UserMin toUserMin(UserSession userSession) => UserMin.fromMap(
        this,
        userSession,
      );

  Category get toCategory => Category.fromMap(this);

  CategorySub get toCategorySub => CategorySub.fromMap(this);

  Chat get toChat => Chat.fromMap(this);

  Tag get toTag => Tag.fromMap(this);

  Plan get toPlan => Plan.fromMap(this);

  Country get toCountry => Country.fromMap(this);

  City get toCity => City.fromMap(this);

  AdComment toAdComment(UserSession userSession) => AdComment.fromMap(
        this,
        userSession,
      );

  Discussion toDiscussion(UserSession userSession) =>
      Discussion.fromMap(this, userSession);

  Message toMessage(String? discussionId, String uid) =>
      Message.fromMap(this, discussionId, uid);
}
