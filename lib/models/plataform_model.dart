import 'package:peat/models/firestore_model.dart';

class PlataformModel extends FirestoreModel {
  static final String collection = 'plataform';
  String codigo;
  String description;
  bool arquived;

  PlataformModel(
    String id, {
    this.codigo,
    this.description,
    this.arquived,
  }) : super(id);
  @override
  PlataformModel fromMap(Map<String, dynamic> map) {
    if (map.containsKey('codigo')) codigo = map['codigo'];
    if (map.containsKey('description')) description = map['description'];
    if (map.containsKey('arquived')) arquived = map['arquived'];
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (codigo != null) data['codigo'] = this.codigo;
    if (description != null) data['description'] = this.description;
    if (arquived != null) data['arquived'] = this.arquived;
    return data;
  }

  Map<String, dynamic> toMapRef() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (codigo != null) data['codigo'] = this.codigo;
    data.addAll({'id': this.id});
    return data;
  }

  PlataformModel copy() {
    return PlataformModel(
      this.id,
      codigo: this.codigo,
      description: this.description,
      arquived: this.arquived,
    );
  }
}
