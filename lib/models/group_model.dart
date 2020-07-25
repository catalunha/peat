import 'package:peat/models/firestore_model.dart';

class GroupModel extends FirestoreModel {
  static final String collection = 'Group';

  String codigo; //p65.200121.01
  String moduleId;
  String plataformId;
  dynamic userDateTimeOnBoard;
  String number;
  String userId;
  dynamic startDtCourse;
  dynamic endDtCourse;
  String localCourse;
  String urlFolder;
  String description;
  bool success;
  dynamic created;
  List<String> workerIdList;
  bool arquived;

  GroupModel(
    String id, {
    this.codigo,
    this.urlFolder,
  }) : super(id);
  @override
  GroupModel fromMap(Map<String, dynamic> map) {
    if (map.containsKey('moduloId')) moduleId = map['moduloId'];
    if (map.containsKey('userId')) userId = map['userId'];
    if (map.containsKey('plataformId')) plataformId = map['plataformId'];
    if (map.containsKey('startDtCourse')) startDtCourse = map['startDtCourse'];
    if (map.containsKey('endDtCourse')) endDtCourse = map['endDtCourse'];
    if (map.containsKey('number')) number = map['number'];
    if (map.containsKey('codigo')) codigo = map['codigo'];
    if (map.containsKey('urlFolder')) urlFolder = map['urlFolder'];
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (codigo != null) data['codigo'] = this.codigo;
    if (urlFolder != null) data['urlFolder'] = this.urlFolder;
    return data;
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}
