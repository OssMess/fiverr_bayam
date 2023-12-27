import '../../controller/services.dart';
import '../list_models.dart';
import '../models.dart';

class ListCompaniesPopular extends SetPaginationClasses<UserMin> {
  ListCompaniesPopular({required super.userSession});

  @override
  Future<void> get({
    required int page,
    required bool refresh,
    void Function()? onComplete,
  }) async {
    await CompanyServices.of(userSession).get(
      page: page,
      refresh: refresh,
      update: super.update,
    );
    if (onComplete != null) {
      onComplete();
    }
  }
}
