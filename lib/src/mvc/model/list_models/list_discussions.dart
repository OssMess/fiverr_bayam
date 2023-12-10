import '../../controller/services.dart';
import '../list_models.dart';
import '../models.dart';

class ListDiscussions extends SetPaginationClasses<Discussion> {
  final DateTime lastDate;

  ListDiscussions({required this.lastDate});

  @override
  Future<void> get({
    required int page,
    required bool refresh,
  }) async {
    await DiscussionServices.get(
      lastDate: lastDate,
      page: page,
      refresh: refresh,
      update: super.update,
    );
  }
}
