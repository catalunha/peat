import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peat/models/user_model.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/states/types_states.dart';

// +++ Actions Sync
class AuthenticationStatusLoggedAction extends ReduxAction<AppState> {
  final AuthenticationStatusLogged authenticationStatusLogged;

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
        firebaseUserLogged: firebaseUser,
      ),
    );
  }

  @override
  void after() => dispatch(GetDocsUserModelLoggedAction(id: firebaseUser.uid));
}

class LoginFailLoggedAction extends ReduxAction<AppState> {
  final dynamic error;

  LoginFailLoggedAction({this.error});

  @override
  AppState reduce() {
    return state.copyWith(
      loggedState: state.loggedState.copyWith(
          firebaseUserLogged: null,
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
        firebaseUserLogged: null,
      ),
    );
  }
}

class SetUserInPlataformLoggedAction extends ReduxAction<AppState> {
  final String id;
  SetUserInPlataformLoggedAction({this.id});
  @override
  AppState reduce() {
    UserModel userModel = state.loggedState.userModelLogged;
    userModel.plataformIdOnBoard = id;
    return state.copyWith(
      loggedState: state.loggedState.copyWith(
        userModelLogged: userModel,
      ),
    );
  }
}

class CurrentUserModelLoggedAction extends ReduxAction<AppState> {
  final UserModel userModel;

  CurrentUserModelLoggedAction({this.userModel});
  @override
  AppState reduce() {
    return state.copyWith(
      loggedState: state.loggedState.copyWith(
        userModelLogged: userModel,
      ),
    );
  }
}

class SetDocUserModelLoggedAction extends ReduxAction<AppState> {
  final String displayName;
  final String sispat;
  final String plataformIdOnBoard;
  final dynamic dateTimeOnBoard;

  SetDocUserModelLoggedAction({
    this.displayName,
    this.sispat,
    this.plataformIdOnBoard,
    this.dateTimeOnBoard,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocUserModelLoggedAction...');
    Firestore firestore = Firestore.instance;
    UserModel userModel = state.loggedState.userModelLogged;

    userModel.displayName = displayName;
    userModel.sispat = sispat;
    userModel.plataformIdOnBoard = plataformIdOnBoard;
    userModel.dateTimeOnBoard = dateTimeOnBoard;
    await firestore
        .collection(UserModel.collection)
        .document(userModel.id)
        .setData(userModel.toMap(), merge: true);
    return state.copyWith(
      loggedState: state.loggedState.copyWith(
        userModelLogged: userModel,
      ),
    );
  }
}

class UpdateDocUserModelLoggedAction extends ReduxAction<AppState> {
  final String plataformIdOnBoard;
  final dynamic dateTimeOnBoard;

  UpdateDocUserModelLoggedAction({
    this.plataformIdOnBoard,
    this.dateTimeOnBoard,
  });
  @override
  Future<AppState> reduce() async {
    print('UpdateDocUserModelLoggedAction...');
    Firestore firestore = Firestore.instance;
    UserModel userModel = state.loggedState.userModelLogged;
    userModel.plataformIdOnBoard = plataformIdOnBoard;
    userModel.dateTimeOnBoard = dateTimeOnBoard;
    final colRef =
        firestore.collection(UserModel.collection).document(userModel.id);
    await colRef.updateData(userModel.toMap());
    return state.copyWith(
      loggedState: state.loggedState.copyWith(
        userModelLogged: userModel,
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

      print(
          '_userLoginEmailPasswordAction: Login bem sucedido. ${currentUser.uid}');
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
      store.dispatch(UpdateDocUserModelLoggedAction(
        dateTimeOnBoard: null,
        plataformIdOnBoard: null,
      ));
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

class GetDocsUserModelLoggedAction extends ReduxAction<AppState> {
  final String id;

  GetDocsUserModelLoggedAction({this.id});
  @override
  Future<AppState> reduce() async {
    print('GetDocsUserModelLoggedAction...$id');
    Firestore firestore = Firestore.instance;

    final docRef = firestore.collection(UserModel.collection).document(id);
    final docSnap = await docRef.get();

    if (docSnap.exists) {
      dispatch(CurrentUserModelLoggedAction(
          userModel: UserModel(docSnap.documentID).fromMap(docSnap.data)));
    } else {
      dispatch(CurrentUserModelLoggedAction(
          userModel: UserModel(id)
              .fromMap({'email': state.loggedState.firebaseUserLogged.email})));
    }
    return null;
  }
}
