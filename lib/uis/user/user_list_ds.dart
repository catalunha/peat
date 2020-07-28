import 'package:flutter/material.dart';
import 'package:peat/models/user_model.dart';

class UserListDS extends StatelessWidget {
  final List<UserModel> userList;

  const UserListDS({
    Key key,
    this.userList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${userList.length} analistas'),
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          final user = userList[index];
          return ListTile(
            title: Text('${user.displayName}'),
            subtitle: Text(
                'SISPAT: ${user.sispat}\nEmail: ${user.email}\nPlataforma OnBoard: ${user.plataformIdOnBoard}\nDate OnBoard: ${user.dateTimeOnBoard}'),
          );
        },
      ),
    );
  }
}
