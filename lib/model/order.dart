class Order {
  final String _clientId;
  final String _addressId;
  final String _status;
  final String _notes;

  Order(this._clientId, this._addressId, this._status, this._notes);

  String get clientId => _clientId;
  String get addressId => _addressId;
  String get status => _status;
  String get notes => _notes;

  Map<String, dynamic> toJson() => {
        'client': {'id': clientId},
        'address': {'id': addressId},
        'status': status,
        'notes': notes,
        'active': 1
      };
}
