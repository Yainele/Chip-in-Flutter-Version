
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class NewEventPage extends StatefulWidget {
  const NewEventPage({Key? key}) : super(key: key);

  @override
  _NewEventPageState createState() => _NewEventPageState();
}
class _NewEventPageState extends State<NewEventPage> {
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    getAllContacts();
    searchController.addListener(() {
      filterContacts();
    });
  }
  getAllContacts() async {
    List<Contact> _contacts = (await ContactsService.getContacts()).toList();
    setState(() {
      contacts = _contacts;
    });
  }
  filterContacts(){
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if(searchController.text.isNotEmpty){
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Запись'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10.0,20.0,10.0,0.0),
        child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Поиск',
                      border: new OutlineInputBorder(
                        borderSide: new BorderSide(
                          color: Theme.of(context).primaryColor
                        )
                      ),
                  prefixIcon: Icon(
                    Icons.search
                  )
                ),
              ),
            ),
            Expanded(
                child:
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: isSearching == true ? contactsFiltered.length : contacts.length,
                  itemBuilder: (context , index) {
                   Contact contact = isSearching == true ? contactsFiltered[index] : contacts[index];
                    return Card(child: ListTile(
                        title: Text((contact.displayName).toString()),
                        subtitle: Text(
                            (contact.phones!.elementAt(0).value).toString()
                        ),
                        leading: (contact.avatar != null && contact.avatar!.length > 0)
                            ? CircleAvatar(
                          //Исправить ошибку с загрузкой пользовательского аватара
                          //Ошибка: The argument type 'Uint8List?' can't be assigned to the parameter type 'Uint8List'
                          //backgroundImage: MemoryImage((contact.avatar)),
                        ) : CircleAvatar(child: Text(contact.initials()),)
                    ));
                  },
                )
            )
          ],
        ),
      ),
    );
  }
}

