import 'package:peat/models/firestore_model.dart';

class WorkerModel extends FirestoreModel {
  static final String collection = 'worker';
  String sispat;
  String displayName;
  String activity;
  String company;
  String plataformIdOnBoard;
  List<String> moduleIdList;
  bool arquived;

  WorkerModel(
    String id, {
    this.displayName,
    this.activity,
    this.company,
    this.sispat,
  }) : super(id);

  @override
  WorkerModel fromMap(Map<String, dynamic> map) {
    if (map.containsKey('displayName')) displayName = map['displayName'];
    if (map.containsKey('sispat')) sispat = map['sispat'];
    if (map.containsKey('activity')) activity = map['activity'];
    if (map.containsKey('company')) company = map['company'];
    if (map.containsKey('arquived')) arquived = map['arquived'];
    if (map.containsKey('plataformIdOnBoard'))
      plataformIdOnBoard = map['plataformIdOnBoard'];
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (displayName != null) data['displayName'] = this.displayName;
    if (sispat != null) data['sispat'] = this.sispat;
    if (activity != null) data['activity'] = this.activity;
    if (company != null) data['company'] = this.company;
    if (arquived != null) data['arquived'] = this.arquived;
    if (plataformIdOnBoard != null)
      data['plataformIdOnBoard'] = this.plataformIdOnBoard;
    return data;
  }

  // @override
  // String toString() {
  //   return this.toMap().toString();
  // }
}
