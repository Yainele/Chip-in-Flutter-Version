class User_profile {
  String _id;
  String? _name;
  String _email;
  String? _photoUri;

  User_profile(
    this._id,
    this._name,
    this._email,
    this._photoUri,
  );

 

  String get id => _id;

  set id(String id) {
    _id = id;
  }

  String? get name => _name;

  set name(String? name) {
    _name = name;
  }
  
  String get email => _email;

  set email(String email) {
    _email = email;
  }

  String? get photoUri => _photoUri;

  set photoUri(String? photoUri) {
    _photoUri = photoUri;
  }

  

}
