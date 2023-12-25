import '../../controller/services.dart';
import '../list_models.dart';
import '../models.dart';

class ListAdsPromoted extends SetPaginationClasses<AdPromoted> {
  ListAdsPromoted({required super.userSession});

  @override
  Future<void> get({
    required int page,
    required bool refresh,
  }) async {
    await AdPromotedServices.of(userSession).getAdsPromoted(
      page: page,
      refresh: refresh,
      update: super.update,
    );
  }
}
