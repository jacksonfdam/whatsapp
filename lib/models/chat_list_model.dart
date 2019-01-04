import 'package:contacts_service/contacts_service.dart';

class ChatListModel {
  List<Contact> chats = <Contact>[];

  void addChat(Contact newChat) {
    if (chats.where((chat) => chat.displayName == newChat.displayName).length ==
        1) {
      return;
    } else {
      chats.insert(0, newChat);
    }
  }
}
