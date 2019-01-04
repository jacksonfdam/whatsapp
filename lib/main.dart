import 'package:flutter/material.dart';
import 'package:whatsapp/models/chat_list_model.dart';
import 'package:whatsapp/pages/contact_list_screen.dart';
import 'package:whatsapp/whatsapp_home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }


}

class MyAppState extends State<MyApp> {
  ChatListModel chats;

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      chats = new ChatListModel();
    }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: "Whatsapp",
      theme: new ThemeData(
        primaryColor: new Color(0xff075E54),
        accentColor: new Color(0xff25D366),
      ),
      home: new WhatsAppHome(chats),
      routes: {
        '/contacts': (context) => ContactListPage(chats),
      },
    );
  }
}
