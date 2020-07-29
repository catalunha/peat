import 'package:peat/models/firestore_model.dart';

class UserModel extends FirestoreModel {
  static final String collection = 'user';
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
    if (map != null) {
      if (map.containsKey('displayName')) displayName = map['displayName'];
      if (map.containsKey('email')) email = map['email'];
      if (map.containsKey('sispat')) sispat = map['sispat'];
      if (map.containsKey('plataformIdOnBoard'))
        plataformIdOnBoard = map['plataformIdOnBoard'];
      dateTimeOnBoard =
          map.containsKey('dateTimeOnBoard') && map['dateTimeOnBoard'] != null
              ? DateTime.fromMillisecondsSinceEpoch(
                  map['dateTimeOnBoard'].millisecondsSinceEpoch)
              : null;
      if (map.containsKey('arquived')) arquived = map['arquived'];
    }
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (displayName != null) data['displayName'] = this.displayName;
    if (email != null) data['email'] = this.email;
    if (sispat != null) data['sispat'] = this.sispat;
    // if (plataformIdOnBoard != null)
    data['plataformIdOnBoard'] = this.plataformIdOnBoard;
    // if (dateTimeOnBoard != null)
    data['dateTimeOnBoard'] = this.dateTimeOnBoard;
    if (arquived != null) data['arquived'] = this.arquived;

    return data;
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}
