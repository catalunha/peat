import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peat/conectors/components/logout_button.dart';
import 'package:peat/routes.dart';

class HomePageDS extends StatelessWidget {
  final String id;
  final String displayName;
  final String sispat;
  final String email;
  final bool userOnBoard;
  final String userPlataformOnBoard;
  final dynamic userDateTimeOnBoard;

  const HomePageDS({
    Key key,
    this.id,
    this.displayName,
    this.email,
    this.userOnBoard,
    this.userPlataformOnBoard,
    this.userDateTimeOnBoard,
    this.sispat,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PEAT'),
        actions: [
          IconButton(
            icon: Icon(Icons.person,
                color: userOnBoard ? Colors.green : Colors.red),
            tooltip:
                'Name: $displayName\nSISPAT:$sispat\nemail: $email\nPlataforma OnBoard: $userPlataformOnBoard\nData OnBoard: ${userDateTimeOnBoard != null ? DateFormat('yyyy-MM-dd').format(userDateTimeOnBoard) : userDateTimeOnBoard}\nid: ${id.substring(0, 5)}',
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
            enabled: userOnBoard,
            leading: Icon(Icons.person),
            title: Text('$displayName'),
            subtitle: Text(
                'SISPAT:$sispat\nemail: $email\nPlataforma OnBoard: $userPlataformOnBoard\nData OnBoard: ${userDateTimeOnBoard != null ? DateFormat('yyyy-MM-dd').format(userDateTimeOnBoard) : userDateTimeOnBoard}\nid: ${id.substring(0, 5)}'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.work),
            title: Text('Analistas'),
            onTap: () => Navigator.pushNamed(context, Routes.userList),
          ),
          ListTile(
            leading: Icon(Icons.place),
            title: Text('Plataformas'),
            onTap: () => Navigator.pushNamed(context, Routes.plataformList),
          ),
          ListTile(
            leading: Icon(Icons.record_voice_over),
            title: Text('Modulos'),
            onTap: () => Navigator.pushNamed(context, Routes.moduleList),
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Trabalhadores'),
            onTap: () => Navigator.pushNamed(context, Routes.workerList),
          ),
        ],
      ),
    );
  }
}
