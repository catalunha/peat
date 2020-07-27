import 'package:flutter/material.dart';
import 'package:peat/models/plataform_model.dart';

class PlataformListDS extends StatelessWidget {
  final List<PlataformModel> plataformList;
  final Function(String) onEditPlataformCurrent;

  const PlataformListDS({
    Key key,
    this.plataformList,
    this.onEditPlataformCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${plataformList.length} Plataformas'),
      ),
      body: ListView.builder(
        itemCount: plataformList.length,
        itemBuilder: (context, index) {
          final plataform = plataformList[index];
          return ListTile(
            title: Text('${plataform.codigo}'),
            subtitle: Text('${plataform.description}'),
            onTap: () {
              onEditPlataformCurrent(plataform.id);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          onEditPlataformCurrent(null);
        },
      ),
    );
  }
}
