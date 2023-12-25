import '../../controller/services.dart';
import '../list_models.dart';
import '../models.dart';

class ListCountries extends SetPaginationClasses<Country> {
  String search;

  ListCountries({
    required super.userSession,
    this.search = '',
  });

  @override
  Future<void> get({
    required int page,
    required bool refresh,
    void Function()? onComplete,
  }) async {
    await CountriesServices.of(userSession).get(
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
