import 'package:flutter/material.dart';
import 'package:peat/conectors/user/user_ordering.dart';
import 'package:peat/models/plataform_model.dart';
import 'package:peat/models/user_model.dart';

class UserListDS extends StatelessWidget {
  final List<UserModel> userList;
  final List<PlataformModel> plataformList;

  const UserListDS({
    Key key,
    this.userList,
    this.plataformList,
  }) : super(key: key);
  String plataform(String plataformId) {
    String _return;
    if (plataformId != null) {
      PlataformModel plataformModel =
          plataformList.firstWhere((element) => element.id == plataformId);
      _return = plataformModel.codigo;
    }
    return _return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${userList.length} usuários'),
        actions: [UserOrdering()],
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          final user = userList[index];
          return Card(
            child: ListTile(
              title: Text('${user.displayName}'),
              subtitle: Text(
                  'SISPAT: ${user.sispat}\nEmail: ${user.email}\nPlataforma OnBoard: ${user.plataformRef?.codigo}\nDate OnBoard: ${user.dateTimeOnBoard}\nuserModel: $user'),
            ),
          );
        },
      ),
    );
  }
}
