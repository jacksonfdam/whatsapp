import 'package:flutter/material.dart';

class WhatsApp extends StatefulWidget {
  @override
  _WhatsAppState createState() => new _WhatsAppState();
}

class _WhatsAppState extends State<WhatsApp> with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("WhatsApp"),
        elevation: 0.7,
      ),
    );
  }
}
