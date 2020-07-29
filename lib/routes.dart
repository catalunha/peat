import 'package:flutter/material.dart';
import 'package:peat/conectors/group/group_edit.dart';
import 'package:peat/conectors/group/group_list.dart';
import 'package:peat/conectors/module/module_edit.dart';
import 'package:peat/conectors/module/module_list.dart';
import 'package:peat/conectors/plataform/plataform_edit.dart';
import 'package:peat/conectors/plataform/plataform_list.dart';
import 'package:peat/conectors/user/user_list.dart';
import 'package:peat/conectors/user/user_logged_edit.dart';
import 'package:peat/conectors/welcome.dart';
import 'package:peat/conectors/worker/worker_edit.dart';
import 'package:peat/conectors/worker/worker_list.dart';
import 'package:peat/conectors/worker/worker_onboard.dart';

class Routes {
  static final home = '/';
  static final userEdit = '/userEdit';
  static final userList = '/userList';
  static final plataformList = '/plataformList';
  static final plataformEdit = '/plataformEdit';
  static final moduleList = '/moduleList';
  static final moduleEdit = '/moduleEdit';
  static final workerList = '/workerList';
  static final workerEdit = '/workerEdit';
  static final workerOnBoard = '/workerOnBoard';
  static final groupList = '/groupList';
  static final groupEdit = '/groupEdit';

  static final routes = {
    // home: (BuildContext context) => UserExceptionDialog<AppState>(
    //       child: Welcome(),
    //     ),
    home: (BuildContext context) => Welcome(),
    userEdit: (BuildContext context) => UserLoggedEdit(),
    userList: (BuildContext context) => UserList(),
    plataformList: (BuildContext context) => PlataformList(),
    plataformEdit: (BuildContext context) => PlataformEdit(),
    moduleList: (BuildContext context) => ModuleList(),
    moduleEdit: (BuildContext context) => ModuleEdit(),
    workerList: (BuildContext context) => WorkerList(),
    workerEdit: (BuildContext context) => WorkerEdit(),
    workerOnBoard: (BuildContext context) => WorkerOnBoard(),
    groupList: (BuildContext context) => GroupList(),
    groupEdit: (BuildContext context) => GroupEdit(),
  };
}

class Keys {
  static final navigatorStateKey = GlobalKey<NavigatorState>();
}
