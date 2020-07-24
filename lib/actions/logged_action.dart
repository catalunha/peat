import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/states/types_states.dart';

// +++ Actions Sync
class AuthenticationStatusLoggedAction extends ReduxAction<AppState> {
  AuthenticationStatusLogged authenticationStatusLogged;

  AuthenticationStatusLoggedAction({this.authenticationStatusLogged});

  @override
  AppState reduce() {
    return state.copyWith(
      loggedState: state.loggedState.copyWith(
        authenticationStatusLogged: this.authenticationStatusLogged,
      ),
    );
  }
}

class LoginSuccessfulLoggedAction extends ReduxAction<AppState> {
  final FirebaseUser firebaseUser;

  LoginSuccessfulLoggedAction({this.firebaseUser});
  @override
  AppState reduce() {
    return state.copyWith(
      loggedState: state.loggedState.copyWith(
        authenticationStatusLogged: AuthenticationStatusLogged.authenticated,
        firebaseUser: firebaseUser,
      ),
    );
  }
}

class LoginFailLoggedAction extends ReduxAction<AppState> {
  final dynamic error;

  LoginFailLoggedAction({this.error});

  @override
  AppState reduce() {
    return state.copyWith(
      loggedState: state.loggedState.copyWith(
          firebaseUser: null,
          authenticationStatusLogged:
              AuthenticationStatusLogged.unAuthenticated),
    );
  }
}

class LogoutSuccessfulLoggedAction extends ReduxAction<AppState> {
  LogoutSuccessfulLoggedAction();
  @override
  AppState reduce() {
    return state.copyWith(
      loggedState: state.loggedState.copyWith(
        authenticationStatusLogged: AuthenticationStatusLogged.unInitialized,
        firebaseUser: null,
      ),
    );
  }
}

// +++ Actions Async

class LoginEmailPasswordLoggedAction extends ReduxAction<AppState> {
  final String email;
  final String password;

  LoginEmailPasswordLoggedAction({this.email, this.password});
  @override
  Future<AppState> reduce() async {
    print('_userLoginEmailPasswordAction...');
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser firebaseUser;
    try {
      store.dispatch(AuthenticationStatusLoggedAction(
          authenticationStatusLogged:
              AuthenticationStatusLogged.authenticating));
      // print(email);
      // print(password);
      final AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      firebaseUser = authResult.user;
      assert(!firebaseUser.isAnonymous);
      assert(await firebaseUser.getIdToken() != null);
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(firebaseUser.uid == currentUser.uid);
      store.dispatch(LoginSuccessfulLoggedAction(firebaseUser: firebaseUser));
      print('_userLoginEmailPasswordAction: Login bem sucedido.');
    } catch (error) {
      store.dispatch(LoginFailLoggedAction(error: error));
      print('_userLoginEmailPasswordAction: Login MAL sucedido. $error');
    }
    return null;
  }
}

class ResetPasswordLoggedAction extends ReduxAction<AppState> {
  final String email;

  ResetPasswordLoggedAction({this.email});
  @override
  Future<AppState> reduce() async {
    print('_userSendPasswordResetEmailAction...');
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      store.dispatch(AuthenticationStatusLoggedAction(
          authenticationStatusLogged:
              AuthenticationStatusLogged.sendPasswordReset));
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      store.dispatch(LoginFailLoggedAction());
    }
    return null;
  }
}

class LogoutLoggedAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    print('_userLogoutAction...');
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signOut();
      store.dispatch(LogoutSuccessfulLoggedAction());
      print('_userLogoutAction: Logout finalizado.');
    } catch (error) {
      print('_userLogoutAction: error: $error');
    }
    return null;
  }
}

class OnAuthStateChangedLoggedAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    print('_userOnAuthStateChangedAction...');
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.currentUser().then((firebaseUser) {
      if (firebaseUser?.uid != null) {
        print('Auth de ultimo login uid: ${firebaseUser.uid}');
        store.dispatch(LoginSuccessfulLoggedAction(firebaseUser: firebaseUser));
      }
    });
    return null;
  }
}
