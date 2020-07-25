import 'package:peat/models/firestore_model.dart';

class UserModel extends FirestoreModel {
  static final String collection = 'User';
  String sispat;
  String accessKey;
  String displayName;
  String photoUrl;
  String email;
  String phoneNumber;
  String plataformIdOnBoard;
  dynamic dateTimeOnBoard;
  bool arquived;

  UserModel(
    String id, {
    this.displayName,
    this.photoUrl,
    this.email,
    this.phoneNumber,
    this.sispat,
  }) : super(id);

  @override
  UserModel fromMap(Map<String, dynamic> map) {
    if (map.containsKey('displayName')) displayName = map['displayName'];
    if (map.containsKey('photoUrl')) photoUrl = map['photoUrl'];
    if (map.containsKey('email')) email = map['email'];
    if (map.containsKey('phoneNumber')) phoneNumber = map['phoneNumber'];
    if (map.containsKey('sispat')) sispat = map['sispat'];
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (displayName != null) data['displayName'] = this.displayName;
    if (photoUrl != null) data['photoUrl'] = this.photoUrl;
    if (email != null) data['email'] = this.email;
    if (phoneNumber != null) data['phoneNumber'] = this.phoneNumber;
    if (sispat != null) data['sispat'] = this.sispat;
    return data;
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}
