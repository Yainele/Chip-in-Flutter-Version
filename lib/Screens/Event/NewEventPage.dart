

import 'dart:io';


import 'package:chip_in_flutter_version/Screens/Event/CreateEvent.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContactListTileWidget extends StatelessWidget {
  final Contact contact;
  final bool isSelected;
  final ValueChanged<Contact> onSelectedContact;
  const ContactListTileWidget(
      {Key? key,
      required this.contact,
      required this.isSelected,
      required this.onSelectedContact})
      : super(key: key);

  get avatar => contact.avatar;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      onTap: () => onSelectedContact(contact),
      title: Text((contact.displayName).toString()),
      trailing: isSelected
          ? Icon(Icons.check, color: Theme.of(context).primaryColor, size: 26)
          : null,
      //subtitle: Text((contact.phones!.elementAt(0).value).toString()),
      leading: (contact.avatar != null && contact.avatar?.length != 0)
          ? CircleAvatar(
              backgroundImage: MemoryImage((avatar)),
            )
          : CircleAvatar(
              child: Text(contact.initials()),
            ),
    ));
  }
}

class NewEventPage extends StatefulWidget {
  final bool isMultiSelection;
  const NewEventPage({Key? key, this.isMultiSelection = true})
      : super(key: key);
  @override
  _NewEventPageState createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  List<Contact> selectedContacts = [];
  bool fabVisibility = false;
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    getAllContacts();
    searchController.addListener(() {
      filterContacts();
    });
  }


   void isVisible(){
    List<Contact> _selectedContacts = [];
    _selectedContacts.addAll(selectedContacts);
    if(selectedContacts.isNotEmpty){
      setState(() {
        fabVisibility = true;
      });
    }
    else
    {
      setState(() {
        fabVisibility = false;
      });
    }
  }

  getAllContacts() async {
    List<Contact> _contacts = (await ContactsService.getContacts()).toList();
    setState(() {
      contacts = _contacts;
    });
  }

  filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      //Доделать поиск по телефонному номеру
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String contactName = contact.displayName.toString().toLowerCase();
        return contactName.contains(searchTerm);
      });
      setState(() {
        contactsFiltered = _contacts;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    isVisible();
    return Scaffold(
      appBar: AppBar(
        title: Text('Запись'),
        actions: [
          Visibility(
            visible: fabVisibility,
              child:  IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 26,
              ),
                      onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CreateEvent(selectedContacts)
                  ));
          },
          ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
        child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    labelText: 'Поиск',
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: Theme.of(context).primaryColor)),
                    prefixIcon: Icon(Icons.search)),
              ),
            ),
            Expanded(
                child: contacts.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: isSearching == true
                            ? contactsFiltered.length
                            : contacts.length,
                        itemBuilder: (context, index) {
                          Contact contact = isSearching == true
                              ? contactsFiltered[index]
                              : contacts[index];
                          final isSelected = selectedContacts.contains(contact);
                          return ContactListTileWidget(
                            contact: contact,
                            isSelected: isSelected,
                            onSelectedContact: selectContact,
                          );
                        },
                      )
                    : Center(
                        child: CupertinoActivityIndicator(),
                      ))
          ],
        ),
      ),
    );
  }

  void selectContact(Contact contact) {
    if (widget.isMultiSelection) {
      final isSelected = selectedContacts.contains(contact);
      setState(() => isSelected
          ? selectedContacts.remove(contact)
          : selectedContacts.add(contact));
    }
  }
}
