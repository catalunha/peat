import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/actions/logged_action.dart';
import 'package:peat/actions/plataform_action.dart';
import 'package:peat/models/plataform_model.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/plataform/plataform_onboard_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<PlataformModel> plataformList;
  Function(PlataformModel) onSetUserInPlataform;
  ViewModel();
  ViewModel.build({
    @required this.plataformList,
    @required this.onSetUserInPlataform,
  }) : super(equals: [
          plataformList,
        ]);
  _plataformList(List<PlataformModel> plataformList) {
    List<PlataformModel> _plataformList = [];
    _plataformList.addAll(plataformList);
    _plataformList.sort((a, b) => a.codigo.compareTo(b.codigo));
    return _plataformList;
  }

  @override
  ViewModel fromStore() => ViewModel.build(
        plataformList: _plataformList(state.plataformState.plataformList),
        onSetUserInPlataform: (PlataformModel plataformModel) {
          // print('id:$id');
          dispatch(SetUserInPlataformSyncLoggedAction(
              plataformModel: plataformModel));
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
          store.dispatch(GetDocsPlataformListAsyncPlataformAction()),
      builder: (context, viewModel) => PlataformOnBoardDS(
        plataformList: viewModel.plataformList,
        onSetUserInPlataform: viewModel.onSetUserInPlataform,
      ),
    );
  }
}
