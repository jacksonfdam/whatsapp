import 'dart:async';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:whatsapp/pages/chat_detail_screen.dart';

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  Iterable<Contact> _contacts;
  Permission readContactsPermission = Permission.ReadContacts;

  @override
  initState() {
    super.initState();
    // refreshContacts();
    requestPermission(readContactsPermission);
  }

  requestPermission(Permission permission) async {
    final canReadContact = await checkPermission(permission);
    if (!canReadContact) {
      final res = await SimplePermissions.requestPermission(permission);
      print("permission request result is " + res.toString());
      refreshContacts();
    } else {
      refreshContacts();
    }
  }

  Future<bool> checkPermission(Permission permission) async {
    bool res = await SimplePermissions.checkPermission(permission);
    print("permission is " + res.toString());
    return res;
  }

  refreshContacts() async {
    var contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTileTheme(
          child: ListTile(
            title: Text('Select Contact'),
            subtitle: Text('${_contacts?.length ?? 0} contacts'),
          ),
          textColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: -5.0, horizontal: 2.0),
        ),
        elevation: 0.7,
      ),
      body: SafeArea(
        child: _contacts != null
            ? ListView.builder(
                itemCount: _contacts?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  Contact c = _contacts?.elementAt(index);
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => ChatDetailScreen(c)
                      ));
                    },
                    leading: (c.avatar != null && c.avatar.length > 0)
                        ? CircleAvatar(backgroundImage: MemoryImage(c.avatar))
                        : CircleAvatar(
                            child: Text(c.displayName.length > 1
                                ? c.displayName?.substring(0, 2)
                                : "")),
                    title: Text(c.displayName ?? ""),
                  );
                },
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
