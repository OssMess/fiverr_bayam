import '../../controller/services.dart';
import '../list_models.dart';
import '../models.dart';

class ListCategories extends SetPaginationClasses<Category> {
  String search;

  ListCategories({
    required super.userSession,
    this.search = '',
  });

  @override
  Future<void> get({
    required int page,
    required bool refresh,
  }) async {
    await CategoriesServices.of(userSession).get(
      search: search,
      page: page,
      refresh: refresh,
      update: super.update,
    );
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
