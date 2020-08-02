import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/actions/plataform_action.dart';
import 'package:peat/models/plataform_model.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/home/home_page_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String id;
  String displayName;
  String sispat;
  String email;
  bool userOnBoard;
  PlataformModel plataformRef;
  dynamic userDateTimeOnBoard;
  ViewModel();
  ViewModel.build({
    @required this.id,
    @required this.displayName,
    @required this.sispat,
    @required this.email,
    @required this.userOnBoard,
    @required this.plataformRef,
    @required this.userDateTimeOnBoard,
  }) : super(equals: [
          id,
          displayName,
          sispat,
          email,
          userOnBoard,
          plataformRef,
          userDateTimeOnBoard,
        ]);
  // String _plataformRef() {
  //   String _return;
  //   PlataformModel plataformModel;
  //   if (state.loggedState.userModelLogged?.plataformRef != null) {
  //     plataformModel = state.plataformState.plataformList.firstWhere(
  //         (element) =>
  //             element.id == state.loggedState.userModelLogged.plataformRef.id);
  //     _return = plataformModel.codigo;
  //   }
  //   return _return;
  // }

  @override
  ViewModel fromStore() => ViewModel.build(
        id: state.loggedState.firebaseUserLogged.uid,
        displayName: state.loggedState.userModelLogged?.displayName ?? '',
        sispat: state.loggedState.userModelLogged?.sispat ?? '',
        email: state.loggedState.userModelLogged?.email ?? '',
        userOnBoard: state.loggedState.userModelLogged?.plataformRef != null,
        plataformRef: state.loggedState.userModelLogged?.plataformRef,
        userDateTimeOnBoard: state.loggedState.userModelLogged?.dateTimeOnBoard,
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
        id: viewModel.id,
        displayName: viewModel.displayName,
        sispat: viewModel.sispat,
        email: viewModel.email,
        userOnBoard: viewModel.userOnBoard,
        plataformRef: viewModel.plataformRef,
        userDateTimeOnBoard: viewModel.userDateTimeOnBoard,
      ),
    );
  }
}
