import '../../controller/services.dart';
import '../list_models.dart';
import '../models.dart';

class ListCategoriesSub extends SetPaginationClasses<CategorySub> {
  String search;

  ListCategoriesSub({
    required super.userSession,
    this.search = '',
  });

  @override
  Future<void> get({
    required int page,
    required bool refresh,
    void Function()? onComplete,
  }) async {
    await CategoriesSubServices.of(userSession).get(
      search: search,
      page: page,
      refresh: refresh,
      update: super.update,
    );
    if (onComplete != null) {
      onComplete();
    }
  }

  Future<void> onUpdateSearch(String search) async {
    this.search = search;
    super.refresh();
  }

  Future<void> onResetSearch() async {
    if (search.isNotEmpty) {
      search = '';
      super.refresh();
    }
  }
}
