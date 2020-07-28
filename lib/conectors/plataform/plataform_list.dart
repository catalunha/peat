import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/actions/plataform_action.dart';
import 'package:peat/models/plataform_model.dart';
import 'package:peat/routes.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/plataform/plataform_list_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<PlataformModel> plataformList;
  Function(String) onEditPlataformCurrent;
  ViewModel();
  ViewModel.build({
    @required this.plataformList,
    @required this.onEditPlataformCurrent,
  }) : super(equals: [
          plataformList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        plataformList: state.plataformState.plataformList,
        onEditPlataformCurrent: (String id) {
          dispatch(SetPlataformCurrentSyncPlataformAction(id));
          dispatch(NavigateAction.pushNamed(Routes.plataformEdit));
        },
      );
}

class PlataformList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) =>
          store.dispatch(GetDocsPlataformListAsyncPlataformAction()),
      builder: (context, viewModel) => PlataformListDS(
        plataformList: viewModel.plataformList,
        onEditPlataformCurrent: viewModel.onEditPlataformCurrent,
      ),
    );
  }
}
