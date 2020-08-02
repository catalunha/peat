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
  // List<ModuleModel> moduleList;
  // List<PlataformModel> plataformList;
  // UserModel userModel;
  List<WorkerModel> workerList;

  Function(String) onEditGroupCurrent;
  ViewModel();
  ViewModel.build({
    @required this.groupList,
    // @required this.moduleList,
    // @required this.plataformList,
    // @required this.userModel,
    @required this.workerList,
    @required this.onEditGroupCurrent,
  }) : super(equals: [
          groupList,
          workerList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        groupList: state.groupState.groupList,
        // moduleList: state.moduleState.moduleList,
        // plataformList: state.plataformState.plataformList,
        // userModel: state.loggedState.userModelLogged,
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
        // store.dispatch(GetDocsModuleListAsyncModuleAction());
        // store.dispatch(GetDocsWorkerListAsyncWorkerAction());
        // store.dispatch(GetDocsPlataformListAsyncPlataformAction());
        store.dispatch(GetDocsGroupListAsyncGroupAction());
      },
      builder: (context, viewModel) => GroupListDS(
        groupList: viewModel.groupList,
        // moduleList: viewModel.moduleList,
        // plataformList: viewModel.plataformList,
        // userModel: viewModel.userModel,
        workerList: viewModel.workerList ?? [],
        onEditGroupCurrent: viewModel.onEditGroupCurrent,
      ),
    );
  }
}
