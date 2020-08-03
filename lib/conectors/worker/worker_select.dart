import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/actions/group_action.dart';
import 'package:peat/actions/worker_action.dart';
import 'package:peat/models/group_model.dart';
import 'package:peat/models/worker_model.dart';

import 'package:peat/states/app_state.dart';
import 'package:peat/uis/worker/worker_select_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<WorkerModel> workerListClean;
  GroupModel groupCurrent;
  Function(WorkerModel, bool) onSetWorkerTheGroupSyncGroupAction;
  ViewModel();
  ViewModel.build({
    @required this.workerListClean,
    @required this.groupCurrent,
    @required this.onSetWorkerTheGroupSyncGroupAction,
  }) : super(equals: [
          groupCurrent,
          workerListClean,
        ]);
  _workerListClean() {
    List<WorkerModel> workerListClean = [];
    workerListClean.addAll(state.workerState.workerList);
    print('workerListClean1: $workerListClean');
    //Remove todos os workers que ja tem este module
    workerListClean.removeWhere((element) {
      if (element.moduleRefMap != null && element.moduleRefMap.isNotEmpty) {
        return element.moduleRefMap
            .containsKey(state.groupState.groupCurrent.moduleRef.id);
      } else {
        return false;
      }
    });
    //Remover todos os workers que ja estao cadastrados em outros groups atuais com este mesmo module
    for (var group in state.groupState.groupList) {
      if (group.workerRefMap != null && group.workerRefMap.isNotEmpty) {
        for (var workerRef in group.workerRefMap.entries) {
          workerListClean.removeWhere((element) {
            return element.id == workerRef.value.id &&
                group.moduleRef.id ==
                    state.groupState.groupCurrent.moduleRef.id;
          });
        }
      }
    }
    print('workerListClean2: $workerListClean');
    workerListClean.sort((a, b) => a.displayName.compareTo(b.displayName));
    return workerListClean;
  }

  @override
  ViewModel fromStore() => ViewModel.build(
        workerListClean: _workerListClean(),
        groupCurrent: state.groupState.groupCurrent,
        onSetWorkerTheGroupSyncGroupAction:
            (WorkerModel workerRef, bool addOrRemove) {
          print('id:${workerRef.id} addOrRemove:$addOrRemove');
          dispatch(SetWorkerTheGroupSyncGroupAction(
            workerRef: workerRef,
            addOrRemove: addOrRemove,
          ));
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
        workerListClean: viewModel.workerListClean,
        groupCurrent: viewModel.groupCurrent,
        onSetWorkerTheGroupSyncGroupAction:
            viewModel.onSetWorkerTheGroupSyncGroupAction,
      ),
    );
  }
}
