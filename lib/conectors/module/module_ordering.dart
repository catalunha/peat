import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:peat/actions/module_action.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/states/types_states.dart';
import 'package:peat/uis/module/module_ordering_ds.dart';

class ViewModel extends BaseModel<AppState> {
  ModuleOrder moduleOrder;
  Function(ModuleOrder) onSelectOrder;
  ViewModel();
  ViewModel.build({
    @required this.moduleOrder,
    @required this.onSelectOrder,
  }) : super(equals: [
          moduleOrder,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        moduleOrder: state.moduleState.moduleOrder,
        onSelectOrder: (ModuleOrder moduleOrder) {
          dispatch(
            SetModuleOrderSyncUserAction(
              moduleOrder,
            ),
          );
        },
      );
}

class ModuleOrdering extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (BuildContext context, ViewModel viewModel) => ModuleOrderingDS(
        moduleOrder: viewModel.moduleOrder,
        onSelectOrder: viewModel.onSelectOrder,
      ),
    );
  }
}
