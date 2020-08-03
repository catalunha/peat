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
    // print('workerListClean: $workerListClean');
    // //Remove todos que ja estao cadastrados para fazer este modulo nos grupos abertos e fechados
    // workerListClean.removeWhere((element) {
    //   print('workerListClean0: ${element.id}');
    //   if (element.moduleIdList != null && element.moduleIdList.isNotEmpty) {
    //     print('workerListClean1: ${element.id}');
    //     print(
    //         'workerListClean2: ${state.groupState.groupCurrent.moduleRef.id}');
    //     print(
    //         'workerListClean3: ${element.moduleIdList.contains(state.groupState.groupCurrent.moduleRef.id)}');
    //     return element.moduleIdList
    //         .contains(state.groupState.groupCurrent.moduleRef.id);
    //   } else {
    //     return false;
    //   }
    // });
    // //remove todos os que ja estao cadastrados em outras grupos deste mesmo modulo
    // for (var group in state.groupState.groupList) {
    //   if (group.workerIdList != null && group.workerIdList.isNotEmpty) {
    //     for (var worker in group.workerIdList) {
    //       workerListClean.removeWhere((element) {
    //         return element.id == worker &&
    //             group.moduleRef.id ==
    //                 state.groupState.groupCurrent.moduleRef.id;
    //       });
    //     }
    //   }
    // }
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
          // dispatch(NavigateAction.pop());
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
