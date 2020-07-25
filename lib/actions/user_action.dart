import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peat/models/user_model.dart';
import 'package:peat/states/app_state.dart';

// Sync
class SetCurrentUserAction extends ReduxAction<AppState> {
  final UserModel userModel;

  SetCurrentUserAction({this.userModel});
  @override
  AppState reduce() {
    return state.copyWith(
      loggedState: state.loggedState.copyWith(
        userModelLogged: userModel,
      ),
    );
  }
}

// Async

class GetUserAction extends ReduxAction<AppState> {
  final String id;

  GetUserAction({this.id});
  @override
  Future<AppState> reduce() async {
    print('GetUserAction...');
    Firestore firestore = Firestore.instance;
    final docRef = firestore.collection(UserModel.collection).document(id);
    final docSnap = await docRef.get();
    if (docSnap.exists) {
      dispatch(SetCurrentUserAction(
          userModel: UserModel(docSnap.documentID).fromMap(docSnap.data)));
    } else {
      dispatch(SetCurrentUserAction(
          userModel: UserModel(docSnap.documentID).fromMap(docSnap.data)));
    }
    return null;
  }
}
