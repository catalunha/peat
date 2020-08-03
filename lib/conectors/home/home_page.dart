import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/actions/plataform_action.dart';
import 'package:peat/models/user_model.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/home/home_page_ds.dart';

class ViewModel extends BaseModel<AppState> {
  UserModel userModel;
  bool userOnBoard;

  ViewModel();
  ViewModel.build({
    @required this.userModel,
    @required this.userOnBoard,
  }) : super(equals: [
          userModel,
          userOnBoard,
        ]);

  @override
  ViewModel fromStore() => ViewModel.build(
        userModel: state.loggedState.userModelLogged,
        userOnBoard: state.loggedState.userModelLogged?.plataformRef != null,
      );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) =>
          store.dispatch(GetDocsPlataformListAsyncPlataformAction()),
      builder: (BuildContext context, ViewModel viewModel) => HomePageDS(
        userModel: viewModel.userModel,
        userOnBoard: viewModel.userOnBoard,
      ),
    );
  }
}
