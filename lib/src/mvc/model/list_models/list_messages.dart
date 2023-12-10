import '../../controller/services.dart';
import '../models.dart';
import 'set_classes.dart';

class ListMessages extends SetClasses<Message> {
  final String discussionId;

  ListMessages({required this.discussionId});

  @override
  Future<void> get({
    required bool refresh,
  }) async {
    Set<Message> result = await MessageServices.get(discussionId: discussionId);
    super.update(
      result,
      false,
      refresh,
    );
  }
}
