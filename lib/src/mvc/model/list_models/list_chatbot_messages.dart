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
      Message botResponse = await ChatGPTServices.sendMessage(
        message: message,
        listChatBotMessages: this,
      );
      botMessage.updateWithChatBotMessage(botResponse);
    } catch (e) {
      list.remove(botMessage);
      notifyListeners();
      myMessage.updateError();
      HiveMessages.save(myMessage);
    }
  }

  Iterable<Map<String, String>> get listChatGPTMap => list
      .where((element) => element.message.isNotEmpty)
      .map((e) => e.toChatGPTMap)
      .toList()
      .reversed;
}
