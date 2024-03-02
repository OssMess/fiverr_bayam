import '../../controller/services.dart';
import '../enums.dart';
import '../list_models.dart';
import '../models.dart';

class ListAdsFilter extends SetPaginationClasses<Ad> {
  String? content;
  String? country;
  String? region;
  AdType? type;

  ListAdsFilter({
    required super.userSession,
  });

  @override
  Future<void> get({
    required int page,
    required bool refresh,
    void Function()? onComplete,
  }) async {
    await AdServices.of(userSession).filterAds(
      content: content,
      country: country,
      region: region,
      type: type,
      page: page,
      refresh: refresh,
      update: super.update,
    );
    if (onComplete != null) {
      onComplete();
    }
  }

  Future<void> filter({
    String? content,
    String? country,
    String? region,
    AdType? type,
    void Function()? onComplete,
  }) async {
    reset();
    await initData(
      callGet: true,
      onComplete: onComplete,
    );
    // notifyListeners();
    // await get(
    //   page: 0,
    //   refresh: true,
    //   onComplete: onComplete,
    // );
  }
}
