import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';
import 'package:peat/conectors/home/home_page.dart';
import 'package:peat/states/app_state.dart';

class Routes {
  static final home = '/';

  static final routes = {
    home: (BuildContext context) => UserExceptionDialog<AppState>(
          child: HomePage(),
        )
  };
}

class Keys {
  static final navigatorStateKey = GlobalKey<NavigatorState>();
}
