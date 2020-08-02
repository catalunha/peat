import 'package:peat/models/firestore_model.dart';
import 'package:peat/models/plataform_model.dart';

class UserModel extends FirestoreModel {
  static final String collection = 'user';
  String sispat;
  String displayName;
  String email;
  PlataformModel plataformRef; //automatico
  dynamic dateTimeOnBoard;
  bool arquived;

  UserModel(
    String id, {
    this.displayName,
    this.email,
    this.sispat,
    this.plataformRef,
    this.dateTimeOnBoard,
    this.arquived,
  }) : super(id);

  @override
  UserModel fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map.containsKey('displayName')) displayName = map['displayName'];
      if (map.containsKey('email')) email = map['email'];
      if (map.containsKey('sispat')) sispat = map['sispat'];
      plataformRef =
          map.containsKey('plataformRef') && map['plataformRef'] != null
              ? PlataformModel(map['id']).fromMap(map['plataformRef'])
              : null;
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
    data['plataformRef'] = this.plataformRef?.toMapRef();
    // if (plataformIdOnBoard != null)
    // if (this.plataformRef == null) {
    //   data['plataformRef'] = null;
    // } else {
    //   data['plataformRef'] = this.plataformRef.toMapRef();
    // }
    // if (dateTimeOnBoard != null)
    data['dateTimeOnBoard'] = this.dateTimeOnBoard;
    if (arquived != null) data['arquived'] = this.arquived;

    return data;
  }

  Map<String, dynamic> toMapRef() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (sispat != null) data['sispat'] = this.sispat;
    if (displayName != null) data['displayName'] = this.displayName;
    data['plataformRef'] = this.plataformRef?.toMapRef();
    data['dateTimeOnBoard'] = this.dateTimeOnBoard;
    data.addAll({'id': this.id});
    return data;
  }

  UserModel copy() {
    return UserModel(
      this.id,
      displayName: this.displayName,
      email: this.email,
      sispat: this.sispat,
      plataformRef: this.plataformRef,
      dateTimeOnBoard: this.dateTimeOnBoard,
      arquived: this.arquived,
    );
  }
}
