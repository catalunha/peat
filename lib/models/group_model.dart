import 'package:peat/models/firestore_model.dart';
import 'package:peat/models/module_model.dart';
import 'package:peat/models/user_model.dart';
import 'package:peat/models/worker_model.dart';

class GroupModel extends FirestoreModel {
  static final String collection = 'group';

  String codigo; //p65.200121.number
  UserModel userRef;
  String number;
  String description;
  dynamic startCourse;
  dynamic endCourse;
  String localCourse;
  String urlFolder;
  String urlPhoto;
  bool opened;
  bool success;
  ModuleModel moduleRef;
  Map<String, WorkerModel> workerRefMap;
  dynamic created;
  bool arquived;

  GroupModel(
    String id, {
    this.codigo,
    this.number,
    this.userRef,
    this.startCourse,
    this.endCourse,
    this.localCourse,
    this.urlFolder,
    this.urlPhoto,
    this.description,
    this.opened,
    this.success,
    this.moduleRef,
    this.workerRefMap,
    this.created,
    this.arquived,
  }) : super(id);
  @override
  GroupModel fromMap(Map<String, dynamic> map) {
    if (map.containsKey('codigo')) codigo = map['codigo'];
    userRef = map.containsKey('userRef') && map['userRef'] != null
        ? UserModel(map['userRef']['id']).fromMap(map['userRef'])
        : null;
    moduleRef = map.containsKey('moduleRef') && map['moduleRef'] != null
        ? ModuleModel(map['moduleRef']['id']).fromMap(map['moduleRef'])
        : null;
    if (map["workerRefMap"] is Map) {
      workerRefMap = Map<String, WorkerModel>();
      map["workerRefMap"].forEach((k, v) {
        workerRefMap[k] = WorkerModel(k).fromMap(v);
      });
    }

    if (map.containsKey('number')) number = map['number'];
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
    if (this.userRef != null) {
      data['userRef'] = this.userRef.toMapRef();
    }
    if (this.moduleRef != null) {
      data['moduleRef'] = this.moduleRef.toMapRef();
    }
    if (workerRefMap != null) {
      Map<String, dynamic> dataFromField = Map<String, dynamic>();
      this.workerRefMap.forEach((k, v) {
        dataFromField[k] = v.toMapRef();
      });
      data['workerRefMap'] = dataFromField;
    }
    if (number != null) data['number'] = this.number;
    if (startCourse != null) data['startCourse'] = this.startCourse;
    if (endCourse != null) data['endCourse'] = this.endCourse;
    if (localCourse != null) data['localCourse'] = this.localCourse;
    if (urlFolder != null) data['urlFolder'] = this.urlFolder;
    if (urlPhoto != null) data['urlPhoto'] = this.urlPhoto;
    if (description != null) data['description'] = this.description;
    if (opened != null) data['opened'] = this.opened;
    if (success != null) data['success'] = this.success;
    if (created != null) data['created'] = this.created;
    if (arquived != null) data['arquived'] = this.arquived;
    return data;
  }

  Map<String, dynamic> toMapRef() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (codigo != null) data['codigo'] = this.codigo;
    data.addAll({'id': this.id});
    return data;
  }

  GroupModel copy() {
    return GroupModel(
      this.id,
      codigo: this.codigo,
      number: this.number,
      userRef: this.userRef,
      startCourse: this.startCourse,
      endCourse: this.endCourse,
      localCourse: this.localCourse,
      urlFolder: this.urlFolder,
      urlPhoto: this.urlPhoto,
      description: this.description,
      opened: this.opened,
      success: this.success,
      moduleRef: this.moduleRef,
      workerRefMap: this.workerRefMap,
      created: this.created,
      arquived: this.arquived,
    );
  }
}
