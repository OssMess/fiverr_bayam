import '../../controller/services.dart';
import '../list_models.dart';
import '../models.dart';

class ListAdsFavorites extends SetPaginationClasses<Ad> {
  ListAdsFavorites({required super.userSession});

  @override
  Future<void> get({
    required int page,
    required bool refresh,
    void Function()? onComplete,
  }) async {
    await FavoritesServices.of(userSession).get(
      page: page,
      refresh: refresh,
      update: super.update,
    );
    if (onComplete != null) {
      onComplete();
    }
  }
}
