import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peat/states/types_states.dart';

class LoginPageDS extends StatefulWidget {
  final Function(String) sendPasswordResetEmail;
  final Function(String, String) loginEmailPassword;
  final AuthenticationStatusLogged authenticationStatus;
  const LoginPageDS({
    Key key,
    this.loginEmailPassword,
    this.authenticationStatus,
    this.sendPasswordResetEmail,
  }) : super(key: key);
  @override
  LoginPageDSState createState() {
    return LoginPageDSState();
  }
}

class LoginPageDSState extends State<LoginPageDS> {
  static final formKey = GlobalKey<FormState>();
  String _userName;
  String _password;
  void validateInputsLogin() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.loginEmailPassword(
        _userName,
        _password,
      );
    } else {
      setState(() {});
    }
  }

  void validateInputsResetPassword() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.sendPasswordResetEmail(_userName);
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PEAT 2- Login Page'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
                Text('Informe os dados'),
                TextFormField(
                  initialValue: 'catalunha.mj@gmail.com',
                  decoration: InputDecoration(
                    labelText: 'Email:',
                  ),
                  onSaved: (value) => _userName = value,
                ),
                TextFormField(
                  initialValue: 'peat@ta',
                  decoration: InputDecoration(
                    labelText: 'Password:',
                  ),
                  onSaved: (value) => _password = value,
                ),
                ListTile(
                  title: Center(child: Text('Logar')),
                  onTap: () {
                    validateInputsLogin();
                  },
                ),
                ListTile(
                  title: Center(child: Text('Pedir Reset senha via email.')),
                  onTap: () {
                    validateInputsResetPassword();
                  },
                ),
                widget.authenticationStatus ==
                        AuthenticationStatusLogged.authenticating
                    ? Center(child: CircularProgressIndicator())
                    : Container(),
                widget.authenticationStatus ==
                        AuthenticationStatusLogged.unAuthenticated
                    ? Text('Verifique Email e a Senha por favor.')
                    : Container(),
                widget.authenticationStatus ==
                        AuthenticationStatusLogged.unInitialized
                    ? Text('Estamos aguardando vc logar.')
                    : Container(),
                widget.authenticationStatus ==
                        AuthenticationStatusLogged.authenticated
                    ? Text('Acesso liberado.')
                    : Container(),
                widget.authenticationStatus ==
                        AuthenticationStatusLogged.sendPasswordReset
                    ? Text('Veja seu email para nova senha.')
                    : Container(),
              ],
            ),
          ),
        ));
  }
}
