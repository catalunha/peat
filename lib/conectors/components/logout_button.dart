import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/actions/logged_action.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/components/logout_button_ds.dart';

class ViewModel extends BaseModel<AppState> {
  void Function() logout;

  ViewModel();
  ViewModel.build({
    @required this.logout,
  }) : super(equals: []);
  @override
  ViewModel fromStore() => ViewModel.build(logout: () {
        return dispatch(LogoutLoggedAction());
      });
}

class LogoutButton extends StatelessWidget {
  LogoutButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) {
        return LogoutButtonDS(
          logout: vm.logout,
        );
      },
    );
  }
}
