import '../../controller/services.dart';
import '../enums.dart';
import '../list_models.dart';
import '../models.dart';

class ListPlans extends SetPaginationClasses<Plan> {
  ListPlans({
    required super.userSession,
  });

  @override
  Future<void> get({
    required int page,
    required bool refresh,
  }) async {
    await PlanServices.of(userSession).get(
      page: page,
      refresh: refresh,
      update: super.update,
    );
  }

  Iterable<Plan> get monthlyCity => list
      .where((element) =>
          element.duration == PlanDuration.monthly &&
          element.place == PlanPlace.byCity)
      .toList();

  Iterable<Plan> get monthlyCountry => list
      .where((element) =>
          element.duration == PlanDuration.monthly &&
          element.place == PlanPlace.byCountry)
      .toList();

  Iterable<Plan> get biannualCity => list
      .where((element) =>
          element.duration == PlanDuration.biannual &&
          element.place == PlanPlace.byCity)
      .toList();

  Iterable<Plan> get biannualCountry => list
      .where((element) =>
          element.duration == PlanDuration.biannual &&
          element.place == PlanPlace.byCountry)
      .toList();

  Iterable<Plan> get annualCity => list
      .where((element) =>
          element.duration == PlanDuration.annual &&
          element.place == PlanPlace.byCity)
      .toList();

  Iterable<Plan> get annualCountry => list
      .where((element) =>
          element.duration == PlanDuration.annual &&
          element.place == PlanPlace.byCountry)
      .toList();

  Iterable<Plan> mapPlans(PlanDuration duration, PlanPlace type) {
    Map<PlanDuration, Map<PlanPlace, Iterable<Plan> Function()>> map = {
      PlanDuration.monthly: {
        PlanPlace.byCity: () => monthlyCity,
        PlanPlace.byCountry: () => monthlyCountry,
      },
      PlanDuration.biannual: {
        PlanPlace.byCity: () => biannualCity,
        PlanPlace.byCountry: () => biannualCountry,
      },
      PlanDuration.annual: {
        PlanPlace.byCity: () => annualCity,
        PlanPlace.byCountry: () => annualCountry,
      },
    };
    return map[duration]![type]!();
  }
}
