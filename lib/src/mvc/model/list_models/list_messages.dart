import '../../controller/services.dart';
import '../list_models.dart';
import '../models.dart';

class ListMessages extends SetPaginationClasses<Message> {
  final String discussionId;
  final DateTime lastDate;

  ListMessages({
    required super.userSession,
    required this.discussionId,
    required this.lastDate,
  });

  @override
  Future<void> get({
    required int page,
    required bool refresh,
  }) async {
    await MessageServices.of(userSession).get(
      uid: userSession.uid!,
      discussionId: discussionId,
      isNull: super.isNull,
      lastDate: lastDate,
      page: page,
      refresh: refresh,
      update: super.update,
    );
  }
}
