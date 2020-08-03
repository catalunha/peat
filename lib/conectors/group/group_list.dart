import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/actions/group_action.dart';
import 'package:peat/actions/module_action.dart';
import 'package:peat/actions/plataform_action.dart';
import 'package:peat/actions/worker_action.dart';
import 'package:peat/models/group_model.dart';
import 'package:peat/models/module_model.dart';
import 'package:peat/models/plataform_model.dart';
import 'package:peat/models/user_model.dart';
import 'package:peat/models/worker_model.dart';
import 'package:peat/routes.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/group/group_list_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<GroupModel> groupList;
  List<WorkerModel> workerList;

  Function(String) onEditGroupCurrent;
  ViewModel();
  ViewModel.build({
    @required this.groupList,
    @required this.workerList,
    @required this.onEditGroupCurrent,
  }) : super(equals: [
          groupList,
          workerList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        groupList: state.groupState.groupList,
        workerList: state.workerState.workerList,
        onEditGroupCurrent: (String id) {
          dispatch(SetGroupCurrentSyncGroupAction(id));
          dispatch(NavigateAction.pushNamed(Routes.groupEdit));
        },
      );
}

class GroupList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) {
        store.dispatch(GetDocsGroupListAsyncGroupAction());
      },
      builder: (context, viewModel) => GroupListDS(
        groupList: viewModel.groupList,
        workerList: viewModel.workerList ?? [],
        onEditGroupCurrent: viewModel.onEditGroupCurrent,
      ),
    );
  }
}
