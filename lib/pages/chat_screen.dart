import 'package:flutter/material.dart';
import 'package:whatsapp/pages/contact_list_screen.dart';

class Contacts extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.white.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: new ContactListPage(),
      ),
    );
  }


  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }

  // TODO: implement opaque
  @override
  bool get opaque => true;
}

class ChatScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new Center(
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "No chats Currently Available, Add Contacts",
          ),
          FlatButton(
            child: Icon(Icons.add),
            onPressed: () => print('here'),
          )
        ],
      ),
    ));
  }
}
