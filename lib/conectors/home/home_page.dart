import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/home/home_page_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String id;
  String displayName;
  String photoUrl;
  String email;
  String phoneNumber;
  ViewModel();
  ViewModel.build({
    @required this.id,
    @required this.displayName,
    @required this.photoUrl,
    @required this.email,
    @required this.phoneNumber,
  }) : super(equals: [
          id,
          displayName,
          photoUrl,
          email,
          phoneNumber,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        id: state.loggedState.firebaseUserLogged.uid,
        displayName: state.loggedState.firebaseUserLogged.displayName,
        photoUrl: state.loggedState.firebaseUserLogged.photoUrl,
        email: state.loggedState.firebaseUserLogged.email,
        phoneNumber: state.loggedState.firebaseUserLogged.phoneNumber,
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
        photoUrl: viewModel.photoUrl,
        email: viewModel.email,
        phoneNumber: viewModel.phoneNumber,
      ),
    );
  }
}
