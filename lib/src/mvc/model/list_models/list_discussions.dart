import '../../controller/services.dart';
import '../models.dart';
import 'set_classes.dart';

class ListDiscussions extends SetClasses<Discussion> {
  @override
  Future<void> get({
    required bool refresh,
  }) async {
    Set<Discussion> result = await DiscussionServices.get();
    super.update(
      result,
      false,
      refresh,
    );
  }
}
