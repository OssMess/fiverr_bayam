import '../../controller/services.dart';
import '../list_models.dart';
import '../models.dart';

class ListCompaniesFilter extends SetPaginationClasses<UserMin> {
  String? content;
  String? country;
  String? region;

  ListCompaniesFilter({
    required super.userSession,
  });

  @override
  Future<void> get({
    required int page,
    required bool refresh,
    void Function()? onComplete,
  }) async {
    await CompanyServices.of(userSession).filterCompanies(
      content: content,
      country: country,
      region: region,
      page: page,
      refresh: refresh,
      update: super.update,
    );
    if (onComplete != null) {
      onComplete();
    }
  }

  Future<void> filter({
    String? content,
    String? country,
    String? region,
    void Function()? onComplete,
  }) async {
    reset();
    this.content = content;
    this.country = country;
    this.region = region;
    await initData(
      callGet: true,
      onComplete: onComplete,
    );
  }
}
