import 'package:peat/models/firestore_model.dart';

class WorkerModel extends FirestoreModel {
  static final String collection = 'Worker';
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
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (displayName != null) data['displayName'] = this.displayName;
    if (sispat != null) data['sispat'] = this.sispat;
    return data;
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}
