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
  Function(String, bool) onSetWorkerTheGroup;
  ViewModel();
  ViewModel.build({
    @required this.workerListClean,
    @required this.groupCurrent,
    @required this.onSetWorkerTheGroup,
  }) : super(equals: [
          groupCurrent,
          workerListClean,
        ]);
  _workerListClean() {
    List<WorkerModel> workerListClean = [];
    workerListClean.addAll(state.workerState.workerList);
    print('workerListClean: $workerListClean');
    //Remove todos que ja estao cadastrados para fazer este modulo nos grupos abertos e fechados
    workerListClean.removeWhere((element) {
      print('workerListClean0: ${element.id}');
      if (element.moduleIdList != null && element.moduleIdList.isNotEmpty) {
        print('workerListClean1: ${element.id}');
        print('workerListClean2: ${state.groupState.groupCurrent.moduleId}');
        print(
            'workerListClean3: ${element.moduleIdList.contains(state.groupState.groupCurrent.moduleId)}');
        return element.moduleIdList
            .contains(state.groupState.groupCurrent.moduleId);
      } else {
        return false;
      }
    });
    //remove todos os que ja estao cadastrados em outras grupos deste mesmo modulo
    for (var group in state.groupState.groupList) {
      if (group.workerIdList != null && group.workerIdList.isNotEmpty) {
        for (var worker in group.workerIdList) {
          workerListClean.removeWhere((element) {
            return element.id == worker &&
                group.moduleId == state.groupState.groupCurrent.moduleId;
          });
        }
      }
    }
    return workerListClean;
  }

  @override
  ViewModel fromStore() => ViewModel.build(
        workerListClean: _workerListClean(),
        groupCurrent: state.groupState.groupCurrent,
        onSetWorkerTheGroup: (String id, bool addOrRemove) {
          print('id:$id addOrRemove:$addOrRemove');
          dispatch(SetWorkerTheGroupSyncGroupAction(
            id: id,
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
        onSetWorkerTheGroup: viewModel.onSetWorkerTheGroup,
      ),
    );
  }
}
