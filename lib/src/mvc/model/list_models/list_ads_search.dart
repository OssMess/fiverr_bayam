import '../../controller/services.dart';
import '../list_models.dart';
import '../models.dart';

class ListAdsSearch extends SetClasses<Ad> {
  String? search;
  ListAdsSearch({required super.userSession});

  @override
  Future<void> get({
    required bool refresh,
    void Function()? onComplete,
  }) async {
    if (isLoading) return;
    isLoading = true;
    notifyListeners();
    await AdServices.of(userSession).getSearch(
      search: search ?? '',
      update: super.update,
    );
    if (onComplete != null) {
      onComplete();
    }
  }

  Future<void> getSearch({
    required String search,
    void Function()? onComplete,
  }) async {
    this.search = search;
    await get(
      refresh: true,
      onComplete: onComplete,
    );
  }

  void updateIsLoading() {
    isLoading = true;
    notifyListeners();
  }
}
