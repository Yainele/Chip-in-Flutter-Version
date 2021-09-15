import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'NewEventPage.dart';
class CreateEvent extends StatefulWidget {
  Contact? contact;
  List<Contact>? _selectedContacts = [];

  CreateEvent(
    List<Contact>? _selectedContacts,
  ) : _selectedContacts = _selectedContacts;
  
  @override
  _CreateEventState createState() => _CreateEventState(_selectedContacts!);
}

class _CreateEventState extends State<CreateEvent> {
  List<Contact> selectedContacts = [];
  _CreateEventState(this.selectedContacts);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Событие"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 150, 10, 50),
        child: Column(
          children:<Widget> [
            Expanded(
                child: selectedContacts.isNotEmpty
                    ?
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: selectedContacts.length,
                        itemBuilder: (context, index){
                          Contact contact = selectedContacts[index];
                          return Card(child: ListTile(
                            title: Text(contact.displayName ?? ''),
                            subtitle: Text(contact.phones?.elementAt(0).value ?? ''),
                            leading: (contact.avatar != null && contact.avatar?.length != 0 )
                                ? CircleAvatar(
                              backgroundImage: MemoryImage(contact.avatar!),
                            ) : CircleAvatar(child: Text(contact.initials()),),
                          ),
                          );
                        }
                    )
                    : Center(
                  child: CupertinoActivityIndicator(),
                )
            )
          ],
        ),
      ),
    );
  }
}
