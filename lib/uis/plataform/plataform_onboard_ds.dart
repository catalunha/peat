import 'package:flutter/material.dart';
import 'package:peat/models/plataform_model.dart';

class PlataformOnBoardDS extends StatelessWidget {
  final List<PlataformModel> plataformList;
  final Function(PlataformModel) onSetUserInPlataform;

  const PlataformOnBoardDS({
    Key key,
    this.plataformList,
    this.onSetUserInPlataform,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 300.0,
        width: 400.0,
        child: ListView.builder(
          itemCount: plataformList.length,
          itemBuilder: (context, index) {
            final plataform = plataformList[index];
            return ListTile(
              title: Text('${plataform.codigo}'),
              subtitle: Text(
                  '${plataform.description}\n${plataform.id.substring(0, 5)}'),
              onTap: () {
                onSetUserInPlataform(plataform);
              },
            );
          },
        ),
      ),
    );
  }
}
