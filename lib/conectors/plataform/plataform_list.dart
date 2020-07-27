import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/actions/plataform_action.dart';
import 'package:peat/models/plataform_model.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/plataform/plataform_list_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<PlataformModel> plataformList;
  ViewModel();
  ViewModel.build({
    @required this.plataformList,
  }) : super(equals: [
          plataformList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        plataformList: state.plataformState.plataformList,
      );
}

class PlataformList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) => store.dispatch(GetListPlatatormAction()),
      builder: (context, viewModel) => PlataformListDS(
        plataformList: viewModel.plataformList,
      ),
    );
  }
}
