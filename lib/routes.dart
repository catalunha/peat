import 'package:flutter/material.dart';
import 'package:peat/conectors/user/user_edit.dart';
import 'package:peat/conectors/welcome.dart';

class Routes {
  static final home = '/';
  static final userEdit = '/userEdit';

  static final routes = {
    // home: (BuildContext context) => UserExceptionDialog<AppState>(
    //       child: Welcome(),
    //     ),
    home: (BuildContext context) => Welcome(),
    userEdit: (BuildContext context) => UserEdit(),
  };
}

class Keys {
  static final navigatorStateKey = GlobalKey<NavigatorState>();
}
