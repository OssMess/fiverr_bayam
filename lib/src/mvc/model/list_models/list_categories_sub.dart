import '../../controller/services.dart';
import '../models.dart';
import 'set_classes.dart';

class ListCategoriesSub extends SetClasses<CategorySub> {
  Set<CategorySub> filterSet = {};
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
    Set<CategorySub> result = await CategoriesSubServices.get();
    super.update(
      result,
      false,
      refresh,
    );
    onChangeFilter(search);
  }
}
