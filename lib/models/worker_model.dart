import 'package:peat/models/firestore_model.dart';

class WorkerModel extends FirestoreModel {
  static final String collection = 'worker';
  String sispat;
  String displayName;
  String company;
  String activity;
  String plataformIdOnBoard;
  List<dynamic> moduleIdList;
  bool arquived;

  WorkerModel(
    String id, {
    this.sispat,
    this.displayName,
    this.activity,
    this.company,
    this.plataformIdOnBoard,
    this.moduleIdList,
    this.arquived,
  }) : super(id);

  @override
  WorkerModel fromMap(Map<String, dynamic> map) {
    if (map.containsKey('displayName')) displayName = map['displayName'];
    if (map.containsKey('sispat')) sispat = map['sispat'];
    if (map.containsKey('activity')) activity = map['activity'];
    if (map.containsKey('company')) company = map['company'];
    if (map.containsKey('arquived')) arquived = map['arquived'];
    if (map.containsKey('moduleIdList')) moduleIdList = map['moduleIdList'];
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
    if (moduleIdList != null) data['moduleIdList'] = this.moduleIdList;
    if (plataformIdOnBoard != null)
      data['plataformIdOnBoard'] = this.plataformIdOnBoard;
    return data;
  }

  WorkerModel copy() {
    return WorkerModel(
      this.id,
      sispat: this.sispat,
      displayName: this.displayName,
      activity: this.activity,
      company: this.company,
      plataformIdOnBoard: this.plataformIdOnBoard,
      moduleIdList: this.moduleIdList,
      arquived: this.arquived,
    );
  }
}
