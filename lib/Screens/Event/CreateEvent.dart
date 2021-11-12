
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  TextEditingController searchController = new TextEditingController();
  List<Contact> contactsFiltered = [];
  List<Contact> selectedContacts = [];
  _CreateEventState(this.selectedContacts);

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      filterContacts();
    });
  }
  filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(selectedContacts);
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
    double CreditValue = 0.0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Событие"),
        actions: [
          Visibility(
              child: IconButton(
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                  size: 26,
                ),
                onPressed: (){
                },
              ),)
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Column(
          children:<Widget> [
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
                child: selectedContacts.isNotEmpty
                    ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: isSearching == true
                      ? contactsFiltered.length
                      : selectedContacts.length,
                  itemBuilder: (context, index) {
                    Contact contact = isSearching == true
                        ? contactsFiltered[index]
                        : selectedContacts[index];
                    return  Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                        side: BorderSide(
                          color: Colors.blue.withOpacity(1.0),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(contact.displayName ?? ''),
                            subtitle: Text(contact.phones?.elementAt(0).value ?? ''),
                            leading: (contact.avatar != null && contact.avatar?.length != 0 )
                                ? CircleAvatar(
                              backgroundImage: MemoryImage(contact.avatar!),
                            ) : CircleAvatar(child: Text(contact.initials()),),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 70,bottom: 20),
                                child: Column(
                                  children: [
                                    Text("Долг: " + CreditValue.toString(),
                                      style: TextStyle(fontSize: 15),
                                      softWrap: true,),],),)],)],),);
                  },
                )
                    : Center(
                  child: CupertinoActivityIndicator(),
                )

            ),
            const Divider(
              thickness: 2,
              color: Colors.blue,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget> [
               SizedBox(
                 height: 65,
                 width: 60,
                 child: OutlinedButton(
                   onPressed: () {
                     showModalBottomSheet(context: context,
                         builder: (context) => buildSheet(context
                         ),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(20),
                         side: BorderSide(
                           color: Colors.blue.withOpacity(1.0),
                           width: 1,),)
                     );
                   },
                   child: Center(
                     child: Icon(Icons.mail, color: Colors.black),
                   ),
                 ),
               ),
                  SizedBox(
                    height: 65,
                    width: 60,
                    child: OutlinedButton(
                      onPressed: () {  },
                      child: Center(
                        child:
                        Icon(Icons.share_outlined, color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 65,
                    width: 150,
                    child: OutlinedButton(
                      onPressed: () {  },
                      child: Center(
                        child: Text('Разделить сумму',
                            style: TextStyle(
                              color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 15.0)
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor:  Colors.blue,
                      ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  //Выплывающее окно для смсок
  Widget buildSheet(BuildContext context) => Container(
    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
    child: Container(
          ),);
  }