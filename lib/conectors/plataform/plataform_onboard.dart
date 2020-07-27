import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/actions/logged_action.dart';
import 'package:peat/actions/plataform_action.dart';
import 'package:peat/models/plataform_model.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/plataform/plataform_onboard_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<PlataformModel> plataformList;
  Function(String) onSetUserInPlataform;
  ViewModel();
  ViewModel.build({
    @required this.plataformList,
    @required this.onSetUserInPlataform,
  }) : super(equals: [
          plataformList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        plataformList: state.plataformState.plataformList,
        onSetUserInPlataform: (String id) {
          print('id:$id');
          dispatch(SetUserInPlataformLoggedAction(id: id));
          dispatch(NavigateAction.pop());
        },
      );
}

class PlataformOnBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) =>
          store.dispatch(GetDocsPlatatormListAsyncPlataformAction()),
      builder: (context, viewModel) => PlataformOnBoardDS(
        plataformList: viewModel.plataformList,
        onSetUserInPlataform: viewModel.onSetUserInPlataform,
      ),
    );
  }
}
