import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:peat/actions/plataform_action.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/states/types_states.dart';
import 'package:peat/uis/plataform/plataform_ordering_ds.dart';

class ViewModel extends BaseModel<AppState> {
  PlataformOrder plataformOrder;
  Function(PlataformOrder) onSelectOrder;
  ViewModel();
  ViewModel.build({
    @required this.plataformOrder,
    @required this.onSelectOrder,
  }) : super(equals: [
          plataformOrder,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        plataformOrder: state.plataformState.plataformOrder,
        onSelectOrder: (PlataformOrder plataformOrder) {
          dispatch(
            SetPlataformOrderSyncUserAction(
              plataformOrder,
            ),
          );
        },
      );
}

class PlataformOrdering extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (BuildContext context, ViewModel viewModel) =>
          PlataformOrderingDS(
        plataformOrder: viewModel.plataformOrder,
        onSelectOrder: viewModel.onSelectOrder,
      ),
    );
  }
}
