import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peat/models/user_model.dart';
import 'package:peat/states/app_state.dart';

class GetDocsUserListAsyncUserAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    print('GetDocsUserListAsyncUserAction...');
    Firestore firestore = Firestore.instance;

    final collRef = firestore.collection(UserModel.collection);
    final docsSnap = await collRef.getDocuments();

    final listDocs = docsSnap.documents
        .map((docSnap) => UserModel(docSnap.documentID).fromMap(docSnap.data))
        .toList();
    return state.copyWith(
      userState: state.userState.copyWith(
        userList: listDocs,
      ),
    );
  }
}
