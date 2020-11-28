class ClientApp {
  final String _name;
  final String _username;
  final String _passwd;
  final String _email;
  final String _phone;

  ClientApp(this._name, this._username, this._passwd, this._email, this._phone);

  String get name => _name;
  String get username => _username;
  String get passwd => _passwd;
  String get email => _email;
  String get phone => _phone;

  Map<String, dynamic> toJson() => {
        'name': name,
        'username': username,
        'passwd': passwd,
        'email': email,
        'phone': phone
      };
}
