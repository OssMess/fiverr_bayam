import '../../controller/services.dart';
import '../list_models.dart';
import '../models.dart';

class ListMessages extends SetPaginationClasses<Message> {
  final String discussionId;
  final DateTime lastDate;

  ListMessages({
    required this.discussionId,
    required this.lastDate,
  });

  @override
  Future<void> get({
    required int page,
    required bool refresh,
  }) async {
    await MessageServices.get(
      discussionId: discussionId,
      lastDate: lastDate,
      page: page,
      refresh: refresh,
      update: super.update,
    );
  }
}
