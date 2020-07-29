import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/actions/group_action.dart';
import 'package:peat/actions/worker_action.dart';
import 'package:peat/models/worker_model.dart';

import 'package:peat/states/app_state.dart';
import 'package:peat/uis/worker/worker_select_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<WorkerModel> workerList;
  Function(String) onSetWorkerTheGroup;
  ViewModel();
  ViewModel.build({
    @required this.workerList,
    @required this.onSetWorkerTheGroup,
  }) : super(equals: [
          workerList,
        ]);
  _workerList() {
    return state.workerState.workerList;
  }

  @override
  ViewModel fromStore() => ViewModel.build(
        workerList: _workerList(),
        onSetWorkerTheGroup: (String id) {
          print('id:$id');
          dispatch(SetWorkerTheGroupSyncGroupAction(id: id));
          dispatch(NavigateAction.pop());
        },
      );
}

class WorkerSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) => store.dispatch(GetDocsWorkerListAsyncWorkerAction()),
      builder: (context, viewModel) => WorkerSelectDS(
        workerList: viewModel.workerList,
        onSetWorkerTheGroup: viewModel.onSetWorkerTheGroup,
      ),
    );
  }
}
