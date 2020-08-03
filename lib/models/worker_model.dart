import 'package:peat/models/firestore_model.dart';
import 'package:peat/models/module_model.dart';
import 'package:peat/models/plataform_model.dart';

class WorkerModel extends FirestoreModel {
  static final String collection = 'worker';
  String sispat;
  String displayName;
  String company;
  String activity;
  PlataformModel plataformRef;
  Map<String, ModuleModel> moduleRefMap;

  bool arquived;

  WorkerModel(
    String id, {
    this.sispat,
    this.displayName,
    this.activity,
    this.company,
    this.plataformRef,
    this.moduleRefMap,
    this.arquived,
  }) : super(id);

  @override
  WorkerModel fromMap(Map<String, dynamic> map) {
    if (map.containsKey('displayName')) displayName = map['displayName'];
    if (map.containsKey('sispat')) sispat = map['sispat'];
    if (map.containsKey('activity')) activity = map['activity'];
    if (map.containsKey('company')) company = map['company'];
    if (map.containsKey('arquived')) arquived = map['arquived'];
    if (map["moduleRefMap"] is Map) {
      moduleRefMap = Map<String, ModuleModel>();
      map["moduleRefMap"].forEach((k, v) {
        moduleRefMap[k] = ModuleModel(k).fromMap(v);
      });
    }
    plataformRef = map.containsKey('plataformRef') &&
            map['plataformRef'] != null
        ? PlataformModel(map['plataformRef']['id']).fromMap(map['plataformRef'])
        : null;
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
    if (moduleRefMap != null) {
      Map<String, dynamic> dataFromField = Map<String, dynamic>();
      this.moduleRefMap.forEach((k, v) {
        dataFromField[k] = v.toMapRef();
      });
      data['moduleRefMap'] = dataFromField;
    }
    data['plataformRef'] = this.plataformRef?.toMapRef();

    return data;
  }

  Map<String, dynamic> toMapRef() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (sispat != null) data['sispat'] = this.sispat;
    if (displayName != null) data['displayName'] = this.displayName;
    if (activity != null) data['activity'] = this.activity;
    if (company != null) data['company'] = this.company;
    data.addAll({'id': this.id});
    return data;
  }

  WorkerModel copy() {
    return WorkerModel(
      this.id,
      sispat: this.sispat,
      displayName: this.displayName,
      activity: this.activity,
      company: this.company,
      plataformRef: this.plataformRef,
      moduleRefMap: this.moduleRefMap,
      arquived: this.arquived,
    );
  }
}
