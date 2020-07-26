import 'package:flutter/material.dart';
import 'package:peat/conectors/components/logout_button.dart';
import 'package:peat/routes.dart';

class HomePageDS extends StatelessWidget {
  final String id;
  final String displayName;
  final String email;
  final bool userInPlataform;

  const HomePageDS({
    Key key,
    this.id,
    this.displayName,
    this.email,
    this.userInPlataform,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PEAT'),
        actions: [
          IconButton(
            icon: Icon(Icons.person,
                color: userInPlataform ? Colors.green : Colors.red),
            tooltip:
                'User: $displayName\nEMail: $email\nId: ${id.substring(0, 5)}',
            onPressed: () {
              Navigator.pushNamed(context, Routes.userEdit);
            },
          ),
          LogoutButton(),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            enabled: userInPlataform,
            leading: Icon(Icons.person),
            title: Text('$displayName'),
            subtitle: Text('email: $email\nid: ${id.substring(0, 5)}'),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
