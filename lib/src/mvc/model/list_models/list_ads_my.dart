import '../../controller/services.dart';
import '../list_models.dart';
import '../models.dart';

class ListAdsMy extends SetPaginationClasses<Ad> {
  ListAdsMy({required super.userSession});

  @override
  Future<void> get({
    required int page,
    required bool refresh,
  }) async {
    await AdServices.of(userSession).getMyAds(
      page: page,
      refresh: refresh,
      update: super.update,
    );
  }
}
