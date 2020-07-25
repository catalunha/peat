import 'package:peat/models/firestore_model.dart';

class UserModel extends FirestoreModel {
  static final String collection = 'User';
  String sispat;
  String displayName;
  String email;
  String plataformIdOnBoard;
  dynamic dateTimeOnBoard;
  bool arquived;

  UserModel(
    String id, {
    this.displayName,
    this.email,
    this.sispat,
  }) : super(id);

  @override
  UserModel fromMap(Map<String, dynamic> map) {
    if (map.containsKey('displayName')) displayName = map['displayName'];
    if (map.containsKey('email')) email = map['email'];
    if (map.containsKey('sispat')) sispat = map['sispat'];
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (displayName != null) data['displayName'] = this.displayName;
    if (email != null) data['email'] = this.email;
    if (sispat != null) data['sispat'] = this.sispat;
    return data;
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}
