import '../../controller/hives.dart';
import '../../controller/services.dart';
import '../list_models.dart';
import '../models.dart';

class ListChatBotMessages extends SetClasses<Message> {
  ListChatBotMessages({
    required super.userSession,
  });

  @override
  Future<void> get({
    required bool refresh,
    void Function()? onComplete,
  }) async {
    super.update(
      HiveMessages.getListMessagesById(('chatbot')).toSet(),
      false,
      refresh,
    );
  }

  Future<void> sendMessage(String message) async {
    Message myMessage = Message.initChatBotMessage(true, message);
    super.insert(myMessage);
    HiveMessages.save(myMessage);
    Message botMessage = Message.initChatBotAwaitingMessage();
    super.insert(botMessage);
    try {
      Message botResponse = await ChatGPTServices.sendMessage(message: message);
      botMessage.updateWithChatBotMessage(botResponse);
      HiveMessages.save(botMessage);
    } catch (e) {
      list.remove(botMessage);
      notifyListeners();
      myMessage.updateError();
      HiveMessages.save(myMessage);
    }
  }
}
