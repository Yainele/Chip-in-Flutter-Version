
import 'package:chip_in_flutter_version/Screens/home/Event.dart';
import 'package:chip_in_flutter_version/Screens/home/Member.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;






class CreateEvent extends StatefulWidget {
  Contact? contact;
  bool isMultiSelection=true;
  List<Contact>? _selectedContacts = [];
  CreateEvent(
    List<Contact>? _selectedContacts,
  ) : _selectedContacts = _selectedContacts;


  
  @override
  _CreateEventState createState() => _CreateEventState(_selectedContacts!);
}

class _CreateEventState extends State<CreateEvent> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
   bool isMultiSelection=true;
   List<Contact> selectedContactsSMS = [];
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
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Событие"),
        actions: [
          Visibility(
              child: IconButton(
                icon: Icon(
                  Icons.save,//сохранение события в дб
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
                            //subtitle: Text(contact.phones?.elementAt(0).value ?? ''),
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
            //Три кнопки внизу экрана
            Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget> [
               SizedBox(
                 height: 65,
                 width: 60,
                 child: OutlinedButton(//кнопка разделить на всех
                   onPressed: () {
                    showBottomSheet(context); 
                   },
                   child: Center(
                     child: Icon(Icons.mail, color: Colors.black),
                   ),
                 ),
               ),
                  SizedBox(
                    height: 65,
                    width: 60,
                    child: OutlinedButton(//кнопка поделиться
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
                      onPressed: () { 
                        
                       },
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
  bool? checkbox1 = false;
  showBottomSheet(context){
    return showModalBottomSheet(
        context: context,
        builder: (builder){
          return StatefulBuilder(builder: (context,StateSetter setstate){
            return Container(
              child: Column(
                children: [
                
                  ListView.builder(
                   shrinkWrap: true,
              itemCount: selectedContacts.length,
              itemBuilder: (context, index){
                Contact contact = selectedContacts[index];
                final isSelected =
                selectedContactsSMS.contains(contact);
                return CheckboxListTile(
                  value: selectedContactsSMS.contains(contact), 
                  title:Text((contact.displayName ?? '').toString()), 
                  onChanged: (bool? value){
                    setstate(() {
                      if(value ?? true){
                        selectedContactsSMS.add(contact); 
                      }
                      else{
                        selectedContactsSMS.remove(contact);
                      }
                    });
                  }
                  );
              }
               )
                ],
              ),
            );
            }
          );
        },
        shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
    side: BorderSide(
    color: Colors.blue.withOpacity(1.0),
    width: 1,),)
    );
  }
  //Выплывающее окно для смсок
  Widget buildSheet(BuildContext context) => Container(
    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),

    child: Container(
      child: ListView.builder(
              shrinkWrap: true,
              itemCount: selectedContacts.length,
              itemBuilder: (context, index)
              {
                Contact contact = selectedContacts[index];
                final isSelected =
                selectedContactsSMS.contains(contact);
                return ContactListTileWidget(
                    contact: contact,
                    isSelected: isSelected,
                    onSelectedContact: selectContact
                    
                );
              }
          ),
    ),
  );
  void selectContact(Contact contact) {
    if (widget.isMultiSelection) {
      final isSelected = selectedContactsSMS.contains(contact);
      setState(() => isSelected
          ? selectedContactsSMS.remove(contact)
          : selectedContactsSMS.add(contact));
    }
  }
  Future<void> SaveEvent(List<Contact>selectedContacts, String Name, String Deadline) async {

    String Id;
    String CreditorName;
    num FullAmount;
    int MemberNumber = selectedContacts.length;
    List<Member>?Members;

    var uuid = Uuid();
    Id = uuid.v1();


         await http.post(
  Uri.parse("https://localhost:44309/api/Events/"),
  body: {
    
  });
    
  }
}

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
  @override
  Widget build(BuildContext context) {
    
    return Card(
      
        child: ListTile(
          onTap: () => onSelectedContact(contact),
          title: Text((contact.displayName ?? '').toString()),
          trailing: isSelected
              ? Icon(Icons.mail_outline, color: Theme.of(context).primaryColor, size: 26)
              : null,
          //subtitle: Text(contact.phones?.elementAt(0).value ?? ''),
        ));
  }
}
