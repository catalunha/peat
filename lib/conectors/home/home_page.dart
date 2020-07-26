import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/home/home_page_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String id;
  String displayName;
  String email;
  bool userOnBoard;
  String userPlataformIdOnBoard;
  dynamic userDateTimeOnBoard;
  ViewModel();
  ViewModel.build({
    @required this.id,
    @required this.displayName,
    @required this.email,
    @required this.userOnBoard,
    @required this.userPlataformIdOnBoard,
    @required this.userDateTimeOnBoard,
  }) : super(equals: [
          id,
          displayName,
          email,
          userOnBoard,
          userPlataformIdOnBoard,
          userDateTimeOnBoard,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        id: state.loggedState.firebaseUserLogged.uid,
        displayName: state.loggedState.userModelLogged?.displayName ?? '',
        email: state.loggedState.userModelLogged?.email ?? '',
        userOnBoard:
            state.loggedState.userModelLogged?.plataformIdOnBoard != null,
        userPlataformIdOnBoard:
            state.loggedState.userModelLogged?.plataformIdOnBoard,
        userDateTimeOnBoard: state.loggedState.userModelLogged?.dateTimeOnBoard,
      );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (BuildContext context, ViewModel viewModel) => HomePageDS(
        id: viewModel.id,
        displayName: viewModel.displayName,
        email: viewModel.email,
        userOnBoard: viewModel.userOnBoard,
        userPlataformIdOnBoard: viewModel.userPlataformIdOnBoard,
        userDateTimeOnBoard: viewModel.userDateTimeOnBoard,
      ),
    );
  }
}
