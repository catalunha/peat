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
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/group/group_list_all_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<GroupModel> groupList;
  // List<ModuleModel> moduleList;
  // List<PlataformModel> plataformList;
  // UserModel userModel;
  // List<WorkerModel> workerList;

  Function(String) onArquivedFalse;
  ViewModel();
  ViewModel.build({
    @required this.groupList,
    // @required this.moduleList,
    // @required this.plataformList,
    // @required this.userModel,
    // @required this.workerList,
    @required this.onArquivedFalse,
  }) : super(equals: [
          groupList,
          // moduleList,
          // plataformList,
          // userModel,
          // workerList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        groupList: state.groupState.groupList,
        // moduleList: state.moduleState.moduleList,
        // plataformList: state.plataformState.plataformList,
        // userModel: state.loggedState.userModelLogged,
        // workerList: state.workerState.workerList,
        onArquivedFalse: (String id) {
          dispatch(
              SetDocGroupAsyncGroupAction(id: id, data: {'arquived': false}));
        },
      );
}

class GroupListAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) {
        store.dispatch(GetDocsModuleListAsyncModuleAction());
        store.dispatch(GetDocsWorkerListAllAsyncWorkerAction());
        store.dispatch(GetDocsGroupListAllAsyncGroupAction());
        store.dispatch(GetDocsPlataformListAsyncPlataformAction());
      },
      builder: (context, viewModel) => GroupListAllDS(
        groupList: viewModel.groupList,
        // moduleList: viewModel.moduleList,
        // plataformList: viewModel.plataformList,
        // userModel: viewModel.userModel,
        // workerList: viewModel.workerList,
        onArquivedFalse: viewModel.onArquivedFalse,
      ),
    );
  }
}
