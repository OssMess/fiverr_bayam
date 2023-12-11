import '../models.dart';
import 'set_classes.dart';

class ListAds extends SetClasses<Ad> {
  ListAds({required super.userSession});

  @override
  Future<void> get({
    required bool refresh,
  }) async {
    // Set<Ad> result = await AdServices.get();
    // super.update(
    //   result,
    //   false,
    //   refresh,
    // );
  }
}
