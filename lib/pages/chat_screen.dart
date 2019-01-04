import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/models/chat_list_model.dart';
import 'package:whatsapp/pages/chat_detail_screen.dart';

class ChatScreen extends StatefulWidget {
  final _chats;
  ChatScreen(this._chats);

  @override
  ChatScreenState createState() {
    return new ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    super.initState();
    // _populateChatList();
  }

  // _populateChatList() {
  //   setState(() {
  //     widget._chats.insertAll(0, widget.chats?.chats);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: widget._chats.chats.length,
      itemBuilder: (context, index) => new Column(
            children: <Widget>[
              new Divider(
                height: 10.0,
              ),
              new ListTile(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => ChatDetailScreen(widget._chats.chats[index])));
                },
                leading: new CircleAvatar(
                    foregroundColor: Theme.of(context).primaryColor,
                    backgroundColor: Colors.grey,
                    backgroundImage: (widget._chats.chats[index].avatar != null &&
                            widget._chats.chats[index].avatar.length > 0)
                        ? MemoryImage(widget._chats.chats[index].avatar)
                        : Text(widget._chats.chats[index].displayName.length > 1
                            ? widget._chats.chats[index].displayName?.substring(0, 2)
                            : "")),
                title: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      widget._chats.chats[index].displayName ?? "",
                      style: new TextStyle(fontWeight: FontWeight.bold),
                    ),
                    new Text(
                      widget._chats.chats[index].displayName ?? "",
                      style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                    ),
                  ],
                ),
                subtitle: new Container(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: new Text(
                    'dummy data',
                    style: new TextStyle(color: Colors.grey, fontSize: 15.0),
                  ),
                ),
              )
            ],
          ),
    );
  }
}
