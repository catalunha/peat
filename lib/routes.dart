import 'package:flutter/material.dart';
import 'package:peat/conectors/module/module_edit.dart';
import 'package:peat/conectors/module/module_list.dart';
import 'package:peat/conectors/plataform/plataform_edit.dart';
import 'package:peat/conectors/plataform/plataform_list.dart';
import 'package:peat/conectors/user/user_edit.dart';
import 'package:peat/conectors/welcome.dart';

class Routes {
  static final home = '/';
  static final userEdit = '/userEdit';
  static final plataformList = '/plataformList';
  static final plataformEdit = '/plataformEdit';
  static final moduleList = '/moduleList';
  static final moduleEdit = '/moduleEdit';

  static final routes = {
    // home: (BuildContext context) => UserExceptionDialog<AppState>(
    //       child: Welcome(),
    //     ),
    home: (BuildContext context) => Welcome(),
    userEdit: (BuildContext context) => UserEdit(),
    plataformList: (BuildContext context) => PlataformList(),
    plataformEdit: (BuildContext context) => PlataformEdit(),
    moduleList: (BuildContext context) => ModuleList(),
    moduleEdit: (BuildContext context) => ModuleEdit(),
  };
}

class Keys {
  static final navigatorStateKey = GlobalKey<NavigatorState>();
}
