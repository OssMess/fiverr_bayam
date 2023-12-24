import '../list_models.dart';
import '../models.dart';

class ListAdsPromoted extends SetPaginationClasses<AdPromoted> {
  ListAdsPromoted({required super.userSession});

  @override
  Future<void> get({
    required int page,
    required bool refresh,
  }) async {
    // Set<Ad> result = await AdPromotedServices.get();
    // super.update(
    //   result,
    //   false,
    //   refresh,
    // );
  }
}
