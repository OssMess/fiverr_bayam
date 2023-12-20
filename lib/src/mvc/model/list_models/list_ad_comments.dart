import '../../controller/services.dart';
import '../list_models.dart';
import '../models.dart';

class ListAdComments extends SetPaginationClasses<AdComment> {
  final String adId;

  ListAdComments({
    required super.userSession,
    required this.adId,
  });

  @override
  Future<void> get({
    required int page,
    required bool refresh,
  }) async {
    await AdServices.of(userSession).getAdComments(
      adId: adId,
      page: page,
      refresh: refresh,
      update: super.update,
    );
  }
}
