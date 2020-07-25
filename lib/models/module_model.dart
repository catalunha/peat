import 'package:peat/models/firestore_model.dart';

class ModuleModel extends FirestoreModel {
  static final String collection = 'Module';
  String codigo; //ciclo01modulo01
  String name;
  String urlFolder;

  bool arquived;

  ModuleModel(
    String id, {
    this.name,
    this.urlFolder,
  }) : super(id);
  @override
  ModuleModel fromMap(Map<String, dynamic> map) {
    if (map.containsKey('name')) name = map['name'];
    if (map.containsKey('urlFolder')) urlFolder = map['urlFolder'];
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (name != null) data['name'] = this.name;
    if (urlFolder != null) data['urlFolder'] = this.urlFolder;
    return data;
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}
