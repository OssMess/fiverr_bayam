import '../models.dart';
import 'set_classes.dart';

class ListAdsPromoted extends SetClasses<AdPromoted> {
  ListAdsPromoted({required super.userSession});

  @override
  Future<void> get({
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
