import 'package:peat/models/firestore_model.dart';

class ModuleModel extends FirestoreModel {
  static final String collection = 'module';
  String codigo; //ciclo01modulo01
  String description;
  String urlFolder;

  bool arquived;

  ModuleModel(
    String id, {
    this.codigo,
    this.description,
    this.urlFolder,
  }) : super(id);
  @override
  ModuleModel fromMap(Map<String, dynamic> map) {
    if (map.containsKey('codigo')) codigo = map['codigo'];
    if (map.containsKey('description')) description = map['description'];
    if (map.containsKey('arquived')) arquived = map['arquived'];
    if (map.containsKey('urlFolder')) urlFolder = map['urlFolder'];
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (codigo != null) data['codigo'] = this.codigo;
    if (description != null) data['description'] = this.description;
    if (arquived != null) data['arquived'] = this.arquived;
    if (urlFolder != null) data['urlFolder'] = this.urlFolder;
    return data;
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}
