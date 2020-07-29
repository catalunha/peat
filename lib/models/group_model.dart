import 'package:peat/models/firestore_model.dart';

class GroupModel extends FirestoreModel {
  static final String collection = 'group';

  String codigo; //p65.200121.01
  String plataformId; //automatico
  dynamic userDateTimeOnBoard; //automatico
  String number;
  String userId; //automatico
  String description;
  dynamic startCourse;
  dynamic endCourse;
  String localCourse;
  String urlFolder;
  String urlPhoto;
  bool opened;
  bool success;
  String moduleId;
  List<dynamic> workerIdList;
  dynamic created; //automatico
  bool arquived;

  GroupModel(
    String id, {
    this.codigo,
    this.plataformId,
    this.userDateTimeOnBoard,
    this.number,
    this.userId,
    this.startCourse,
    this.endCourse,
    this.localCourse,
    this.urlFolder,
    this.urlPhoto,
    this.description,
    this.opened,
    this.success,
    this.moduleId,
    this.workerIdList,
    this.created,
    this.arquived,
  }) : super(id);
  @override
  GroupModel fromMap(Map<String, dynamic> map) {
    if (map.containsKey('codigo')) codigo = map['codigo'];
    if (map.containsKey('plataformId')) plataformId = map['plataformId'];
    userDateTimeOnBoard = map.containsKey('userDateTimeOnBoard') &&
            map['userDateTimeOnBoard'] != null
        ? DateTime.fromMillisecondsSinceEpoch(
            map['userDateTimeOnBoard'].millisecondsSinceEpoch)
        : null;
    if (map.containsKey('number')) number = map['number'];
    if (map.containsKey('userId')) userId = map['userId'];
    if (map.containsKey('moduloId')) moduleId = map['moduloId'];
    startCourse = map.containsKey('startCourse') && map['startCourse'] != null
        ? DateTime.fromMillisecondsSinceEpoch(
            map['startCourse'].millisecondsSinceEpoch)
        : null;
    endCourse = map.containsKey('endCourse') && map['endCourse'] != null
        ? DateTime.fromMillisecondsSinceEpoch(
            map['endCourse'].millisecondsSinceEpoch)
        : null;
    if (map.containsKey('localCourse')) localCourse = map['localCourse'];
    if (map.containsKey('urlFolder')) urlFolder = map['urlFolder'];
    if (map.containsKey('urlPhoto')) urlPhoto = map['urlPhoto'];
    if (map.containsKey('description')) description = map['description'];
    if (map.containsKey('opened')) opened = map['opened'];
    if (map.containsKey('success')) success = map['success'];
    if (map.containsKey('arquived')) arquived = map['arquived'];
    if (map.containsKey('moduleId')) moduleId = map['moduleId'];
    if (map.containsKey('workerIdList')) workerIdList = map['workerIdList'];
    created = map.containsKey('created') && map['created'] != null
        ? DateTime.fromMillisecondsSinceEpoch(
            map['created'].millisecondsSinceEpoch)
        : null;
    if (map.containsKey('arquived')) arquived = map['arquived'];
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (codigo != null) data['codigo'] = this.codigo;
    if (plataformId != null) data['plataformId'] = this.plataformId;
    if (userDateTimeOnBoard != null)
      data['userDateTimeOnBoard'] = this.userDateTimeOnBoard;
    if (number != null) data['number'] = this.number;
    if (userId != null) data['userId'] = this.userId;
    if (startCourse != null) data['startCourse'] = this.startCourse;
    if (endCourse != null) data['endCourse'] = this.endCourse;
    if (localCourse != null) data['localCourse'] = this.localCourse;
    if (urlFolder != null) data['urlFolder'] = this.urlFolder;
    if (urlPhoto != null) data['urlPhoto'] = this.urlPhoto;
    if (description != null) data['description'] = this.description;
    if (opened != null) data['opened'] = this.opened;
    if (success != null) data['success'] = this.success;
    if (moduleId != null) data['moduleId'] = this.moduleId;
    if (workerIdList != null) data['workerIdList'] = this.workerIdList;
    if (created != null) data['created'] = this.created;
    if (arquived != null) data['arquived'] = this.arquived;
    return data;
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}
