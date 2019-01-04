import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Bubble extends StatelessWidget {
  Bubble({this.message, this.time, this.delivered, this.isMe});

  final String message, time;
  final delivered, isMe;

  @override
  Widget build(BuildContext context) {
    final bg = isMe ? Colors.white : Colors.greenAccent.shade100;
    final align = isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final icon = delivered ? Icons.done_all : Icons.done;
    final radius = isMe
        ? BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          );
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: .5,
                  spreadRadius: 1.0,
                  color: Colors.black.withOpacity(.12))
            ],
            color: bg,
            borderRadius: radius,
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 48.0),
                child: Text(message),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Row(
                  children: <Widget>[
                    Text(time,
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 10.0,
                        )),
                    SizedBox(width: 3.0),
                    Icon(
                      icon,
                      size: 12.0,
                      color: Colors.black38,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class ChatDetailScreen extends StatefulWidget {
  ChatDetailScreen(this._contact);
  final Contact _contact;

  @override
  ChatDetailScreenState createState() {
    return new ChatDetailScreenState();
  }
}

class ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _chatController = new TextEditingController();
  final List<Bubble> _messages = <Bubble>[];

  @override
  void initState() {
    super.initState();
    _populateChat();
  }

  void _populateChat() {
    List<Bubble> dummyChat = [
      Bubble(
        message: 'Hi there, this is a message',
        time: '12:00',
        delivered: true,
        isMe: false,
      ),
      Bubble(
        message: 'Whatsapp like bubble talk',
        time: '12:01',
        delivered: true,
        isMe: false,
      ),
      Bubble(
        message: 'Nice one, Flutter is awesome',
        time: '12:00',
        delivered: true,
        isMe: true,
      ),
      Bubble(
        message: 'I\'ve told you so dude!',
        time: '12:00',
        delivered: true,
        isMe: false,
      ),
    ];

    setState(() {
      _messages.insertAll(0, dummyChat);
    });
  }

  void _sendMessage(String text) {
    _chatController.clear();
    var formatter = new DateFormat('jm');
    var now = formatter.format(new DateTime.now());
    Bubble message = new Bubble(
      delivered: true,
      isMe: false,
      time: now.toString(),
      message: text,
    );

    setState(() {
      _messages.insert(0, message);
    });
  }

  Widget _chatEnvironment() {
    return IconTheme(
      data: new IconThemeData(color: Colors.blue),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                decoration:
                    new InputDecoration.collapsed(hintText: "Start typing ..."),
                controller: _chatController,
                onSubmitted: _sendMessage,
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => _sendMessage(_chatController.text),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: .9,
        title: Text(
          widget._contact.displayName,
          style: TextStyle(color: Colors.white),
        ),
        leading: (widget._contact.avatar != null &&
                widget._contact.avatar.length > 0)
            ? CircleAvatar(
                backgroundImage: MemoryImage(widget._contact.avatar),
              )
            : CircleAvatar(
                child: Text(widget._contact.displayName.length > 1
                    ? widget._contact.displayName?.substring(0, 2)
                    : ""),
              ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.videocam,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.call,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Flexible(
              child: ListView.builder(
                padding: new EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
            new Divider(
              height: 1.0,
            ),
            new Container(
              decoration: new BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: _chatEnvironment(),
            ),
          ],
        ),
      ),
    );
  }
}
