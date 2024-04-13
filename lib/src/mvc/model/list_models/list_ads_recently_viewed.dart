import '../../controller/services.dart';
import '../list_models.dart';
import '../models.dart';

class ListAdsRecentlyViewed extends SetPaginationClasses<Ad> {
  ListAdsRecentlyViewed({required super.userSession});

  @override
  Future<void> get({
    required int page,
    required bool refresh,
    void Function()? onComplete,
  }) async {
    await AdServices.of(userSession).getRecentlyViewed(
      page: page,
      refresh: refresh,
      update: super.update,
    );
    if (onComplete != null) {
      onComplete();
    }
  }
}
