import '../../controller/services.dart';
import '../models.dart';
import 'set_classes.dart';

class ListCategories extends SetClasses<Category> {
  Set<Category> filterSet = {};
  String search = '';

  void onChangeFilter(String search) {
    this.search = search;
    filterSet.clear();
    if (search.isEmpty) {
      filterSet.addAll(super.list);
    } else {
      filterSet.addAll(
        super.list.where((element) =>
            element.name.toLowerCase().contains(search.toLowerCase())),
      );
    }
    notifyListeners();
  }

  @override
  Future<void> get({
    required bool refresh,
  }) async {
    Set<Category> result = await CategoriesServices.get();
    super.update(
      result,
      false,
      refresh,
    );
  }
}
