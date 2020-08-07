import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peat/conectors/components/logout_button.dart';
import 'package:peat/models/user_model.dart';
import 'package:peat/routes.dart';

class HomePageDS extends StatelessWidget {
  final UserModel userModel;
  final bool userOnBoard;

  const HomePageDS({
    Key key,
    this.userModel,
    this.userOnBoard,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'PEAT - ${userModel?.sispat} na ${userModel?.plataformRef?.codigo} em ${userModel?.dateTimeOnBoard != null ? DateFormat('yyyy-MM-dd').format(userModel?.dateTimeOnBoard) : userModel?.dateTimeOnBoard}'),
        actions: [
          IconButton(
            icon: Icon(Icons.person,
                color: userOnBoard ? Colors.green : Colors.red),
            tooltip:
                'Name: ${userModel?.displayName}\nSISPAT:${userModel?.sispat}\nemail: ${userModel?.email}\nPlataforma OnBoard: ${userModel?.plataformRef?.codigo}\nData OnBoard: ${userModel?.dateTimeOnBoard != null ? DateFormat('yyyy-MM-dd').format(userModel?.dateTimeOnBoard) : userModel?.dateTimeOnBoard}\nid: $userModel',
            onPressed: () {
              Navigator.pushNamed(context, Routes.userEdit);
            },
          ),
          LogoutButton(),
        ],
      ),
      body: ListView(
        children: [
          // ListTile(
          //   enabled: false,
          //   title: Text('${userModel?.displayName}'),
          //   subtitle: Text('$userModel'),
          // ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Trabalhadores'),
            onTap: () => Navigator.pushNamed(context, Routes.workerList),
          ),
          ListTile(
            enabled: userOnBoard,
            leading: Icon(Icons.directions_boat),
            title: Text('Check PeopleOnBoard'),
            onTap: () => Navigator.pushNamed(context, Routes.workerOnBoard),
          ),
          ListTile(
            enabled: userOnBoard,
            leading: Icon(Icons.art_track),
            title: Text('Seus grupos ativos'),
            onTap: () => Navigator.pushNamed(context, Routes.groupList),
          ),
          ListTile(
            enabled: userOnBoard,
            leading: Icon(Icons.track_changes),
            title: Text('Grupos desta plataforma'),
            onTap: () => Navigator.pushNamed(context, Routes.groupListAll),
          ),
          Row(
            children: [
              Expanded(child: Divider(thickness: 2)),
              Text('Administradores'),
              Expanded(child: Divider(thickness: 2)),
            ],
          ),
          ListTile(
            leading: Icon(
              Icons.work,
            ),
            title: Text('Usuários'),
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
          Row(
            children: [
              Expanded(child: Divider(thickness: 2)),
              Text('Acesso restrito'),
              Expanded(child: Divider(thickness: 2)),
            ],
          ),
          ListTile(
            leading: Icon(Icons.people_outline),
            title: Text('Todos os trabalhadores'),
            onTap: () => Navigator.pushNamed(context, Routes.workerListAll),
          ),
          ListTile(
            leading: Icon(Icons.text_fields),
            title: Text('Report'),
            onTap: () => Navigator.pushNamed(context, Routes.report),
          ),
        ],
      ),
    );
  }
}
