import 'package:peat/models/firestore_model.dart';

class PlataformModel extends FirestoreModel {
  static final String collection = 'Plataform';
  String codigo;
  String name;
  bool arquived;

  PlataformModel(
    String id, {
    this.name,
  }) : super(id);
  @override
  PlataformModel fromMap(Map<String, dynamic> map) {}

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    return data;
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}
