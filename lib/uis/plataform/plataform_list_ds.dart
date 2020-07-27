import 'package:flutter/material.dart';
import 'package:peat/models/plataform_model.dart';

class PlataformListDS extends StatelessWidget {
  final List<PlataformModel> plataformList;

  const PlataformListDS({
    Key key,
    this.plataformList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Plataformas'),
      ),
      body: ListView.builder(
        itemCount: plataformList.length,
        itemBuilder: (context, index) {
          final plataform = plataformList[index];
          return ListTile(
            title: Text('${plataform.codigo}'),
            subtitle: Text('${plataform.description}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
