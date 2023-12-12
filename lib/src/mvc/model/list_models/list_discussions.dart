import '../../controller/services.dart';
import '../list_models.dart';
import '../models.dart';

class ListDiscussions extends SetPaginationClasses<Discussion> {
  ListDiscussions({required super.userSession});

  @override
  Future<void> get({
    required int page,
    required bool refresh,
  }) async {
    await DiscussionServices.of(userSession).get(
      page: page,
      refresh: refresh,
      update: super.update,
    );
  }
}
