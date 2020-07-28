import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';
import 'package:peat/actions/user_action.dart';
import 'package:peat/models/plataform_model.dart';
import 'package:peat/models/user_model.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/user/user_list_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<UserModel> userList;
  List<PlataformModel> plataformList;
  ViewModel();
  ViewModel.build({
    @required this.userList,
    @required this.plataformList,
  }) : super(equals: [
          userList,
          plataformList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        userList: state.userState.userList,
        plataformList: state.plataformState.plataformList,
      );
}

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) => store.dispatch(GetDocsUserListAsyncUserAction()),
      builder: (context, viewModel) => UserListDS(
        userList: viewModel.userList,
        plataformList: viewModel.plataformList,
      ),
    );
  }
}
