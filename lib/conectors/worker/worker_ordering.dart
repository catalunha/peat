import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:peat/actions/worker_action.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/states/types_states.dart';
import 'package:peat/uis/worker/worker_ordering_ds.dart';

class ViewModel extends BaseModel<AppState> {
  WorkerOrder workerOrder;
  Function(WorkerOrder) onSelectOrder;
  ViewModel();
  ViewModel.build({
    @required this.workerOrder,
    @required this.onSelectOrder,
  }) : super(equals: [
          workerOrder,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        workerOrder: state.workerState.workerOrder,
        onSelectOrder: (WorkerOrder workerOrder) {
          dispatch(
            SetWorkerOrderSyncUserAction(
              workerOrder,
            ),
          );
        },
      );
}

class WorkerOrdering extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (BuildContext context, ViewModel viewModel) => WorkerOrderingDS(
        workerOrder: viewModel.workerOrder,
        onSelectOrder: viewModel.onSelectOrder,
      ),
    );
  }
}
