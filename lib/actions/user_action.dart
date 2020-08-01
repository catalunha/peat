import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peat/models/user_model.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/states/types_states.dart';

class SetUserOrderSyncUserAction extends ReduxAction<AppState> {
  final UserOrder userOrder;

  SetUserOrderSyncUserAction(this.userOrder);
  @override
  AppState reduce() {
    List<UserModel> _userList = [];
    _userList.addAll(state.userState.userList);
    // print(userList);
    if (userOrder == UserOrder.sispat) {
      _userList.sort((a, b) => a.sispat.compareTo(b.sispat));
    } else if (userOrder == UserOrder.displayName) {
      _userList.sort((a, b) => a.displayName.compareTo(b.displayName));
    } else if (userOrder == UserOrder.plataformIdOnBoard) {
      List<UserModel> userListWithNull = [];
      List<UserModel> userListWithoutNull = [];
      userListWithNull.addAll(_userList);
      userListWithNull
          .removeWhere((element) => element.plataformIdOnBoard != null);
      userListWithoutNull.addAll(_userList);
      userListWithoutNull
          .removeWhere((element) => element.plataformIdOnBoard == null);
      userListWithoutNull.sort(
          (a, b) => a.plataformIdOnBoard?.compareTo(b.plataformIdOnBoard));
      _userList = [];
      _userList.addAll(userListWithoutNull);
      _userList.addAll(userListWithNull);
    } else if (userOrder == UserOrder.dateTimeOnBoard) {
      List<UserModel> userListWithNull = [];
      List<UserModel> userListWithoutNull = [];
      userListWithNull.addAll(_userList);
      userListWithNull
          .removeWhere((element) => element.dateTimeOnBoard != null);
      userListWithoutNull.addAll(_userList);
      userListWithoutNull
          .removeWhere((element) => element.dateTimeOnBoard == null);
      userListWithoutNull
          .sort((a, b) => a.dateTimeOnBoard?.compareTo(b.dateTimeOnBoard));
      _userList = [];
      _userList.addAll(userListWithoutNull);
      _userList.addAll(userListWithNull);
    }
    // print(userList);
    return state.copyWith(
      userState: state.userState.copyWith(
        userOrder: userOrder,
        userList: _userList,
      ),
    );
  }
}

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
