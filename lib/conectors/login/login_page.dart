import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';
import 'package:peat/actions/logged_action.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/states/types_states.dart';
import 'package:peat/uis/login/login_page_ds.dart';

class ViewModel extends BaseModel<AppState> {
  Function(String) onResetEmail;
  Function(String, String) onLoginEmailPassword;
  AuthenticationStatusLogged authenticationStatusLogged;

  ViewModel();

  ViewModel.build({
    @required this.onLoginEmailPassword,
    @required this.authenticationStatusLogged,
    @required this.onResetEmail,
  }) : super(equals: [authenticationStatusLogged]);
  @override
  ViewModel fromStore() => ViewModel.build(
        onLoginEmailPassword: (String email, String password) {
          dispatch(
              LoginEmailPasswordLoggedAction(email: email, password: password));
        },
        authenticationStatusLogged:
            state.loggedState.authenticationStatusLogged,
        onResetEmail: (String email) {
          dispatch(ResetPasswordLoggedAction(email: email));
        },
      );
}

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (BuildContext context, ViewModel viewModel) {
        return LoginPageDS(
          loginEmailPassword: viewModel.onLoginEmailPassword,
          authenticationStatusLogged: viewModel.authenticationStatusLogged,
          sendPasswordResetEmail: viewModel.onResetEmail,
        );
      },
    );
  }
}
