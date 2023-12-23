import '../../controller/services.dart';
import '../list_models.dart';
import '../models.dart';

class ListAds extends SetPaginationClasses<Ad> {
  ListAds({required super.userSession});

  @override
  Future<void> get({
    required int page,
    required bool refresh,
  }) async {
    await AdServices.of(userSession).getAds(
      page: page,
      refresh: refresh,
      update: super.update,
    );
  }
}
