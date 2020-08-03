import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/actions/group_action.dart';
import 'package:peat/actions/module_action.dart';
import 'package:peat/actions/worker_action.dart';
import 'package:peat/models/module_model.dart';
import 'package:peat/models/worker_model.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/group/group_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String codigo;
  String number;
  String description;
  dynamic startCourse;
  dynamic endCourse;
  String localCourse;
  String urlFolder;
  String urlPhoto;
  ModuleModel moduleRef;
  Map<String, WorkerModel> workerRefMap;
  bool opened;
  bool success;
  bool arquived;
  bool isCreateOrUpdate;
  Function(
    String,
    String,
    String,
    dynamic,
    dynamic,
    String,
    String,
    String,
  ) onCreate;
  Function(
    String,
    String,
    String,
    dynamic,
    dynamic,
    String,
    String,
    String,
    bool,
    bool,
    bool,
  ) onUpdate;
  Function() onEditPop;
  Function(
    WorkerModel,
    bool,
  ) onSetWorkerTheGroupSyncGroupAction;

  List<WorkerModel> workerList;

  ViewModel();
  ViewModel.build({
    @required this.codigo,
    @required this.number,
    @required this.description,
    @required this.startCourse,
    @required this.endCourse,
    @required this.localCourse,
    @required this.urlFolder,
    @required this.urlPhoto,
    @required this.moduleRef,
    @required this.workerRefMap,
    @required this.opened,
    @required this.success,
    @required this.arquived,
    @required this.isCreateOrUpdate,
    @required this.onCreate,
    @required this.onUpdate,
    @required this.onEditPop,
    @required this.onSetWorkerTheGroupSyncGroupAction,
    @required this.workerList,
  }) : super(equals: [
          codigo,
          number,
          description,
          startCourse,
          endCourse,
          localCourse,
          urlFolder,
          urlPhoto,
          moduleRef,
          workerRefMap,
          opened,
          success,
          arquived,
          isCreateOrUpdate,
          workerList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        codigo: state.groupState.groupCurrent.codigo,
        number: state.groupState.groupCurrent.number,
        description: state.groupState.groupCurrent.description,
        startCourse: state.groupState.groupCurrent.startCourse,
        endCourse: state.groupState.groupCurrent.endCourse,
        localCourse: state.groupState.groupCurrent.localCourse,
        urlFolder: state.groupState.groupCurrent.urlFolder,
        urlPhoto: state.groupState.groupCurrent.urlPhoto,
        moduleRef: state.groupState.groupCurrent.moduleRef,
        workerRefMap: state.groupState.groupCurrent.workerRefMap,
        opened: state.groupState.groupCurrent?.opened ?? true,
        success: state.groupState.groupCurrent?.success ?? false,
        arquived: state.groupState.groupCurrent?.arquived ?? false,
        isCreateOrUpdate: state.groupState.groupCurrent.id == null,
        onCreate: (
          String codigo,
          String number,
          String description,
          dynamic startCourse,
          dynamic endCourse,
          String localCourse,
          String urlFolder,
          String urlPhoto,
        ) {
          print('GroupEdit.onCreate');
          dispatch(CreateDocGroupCurrentAsyncGroupAction(
            codigo: codigo,
            number: number,
            description: description,
            startCourse: startCourse,
            endCourse: endCourse,
            localCourse: localCourse,
            urlFolder: urlFolder,
            urlPhoto: urlPhoto,
            userDateTimeOnBoard:
                state.loggedState.userModelLogged.dateTimeOnBoard,
          ));
          dispatch(NavigateAction.pop());
        },
        onUpdate: (
          String codigo,
          String number,
          String description,
          dynamic startCourse,
          dynamic endCourse,
          String localCourse,
          String urlFolder,
          String urlPhoto,
          bool opened,
          bool success,
          bool arquived,
        ) {
          print('GroupEdit.onUpdate');
          dispatch(UpdateDocGroupCurrentAsyncGroupAction(
            codigo: codigo,
            number: number,
            description: description,
            startCourse: startCourse,
            endCourse: endCourse,
            localCourse: localCourse,
            urlFolder: urlFolder,
            urlPhoto: urlPhoto,
            opened: opened,
            success: success,
            arquived: arquived,
          ));
          dispatch(NavigateAction.pop());
        },
        onEditPop: () {
          dispatch(GetDocsGroupListAsyncGroupAction());
          dispatch(NavigateAction.pop());
        },
        onSetWorkerTheGroupSyncGroupAction:
            (WorkerModel workerRef, bool addOrRemove) {
          // print('id:${workerRef.id} addOrRemove:$addOrRemove');
          dispatch(SetWorkerTheGroupSyncGroupAction(
              workerRef: workerRef, addOrRemove: addOrRemove));
        },
        workerList: state.workerState.workerList ?? [],
      );
}

class GroupEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) {
        store.dispatch(GetDocsWorkerListAsyncWorkerAction());
        store.dispatch(GetDocsModuleListAsyncModuleAction());
      },
      builder: (context, viewModel) => GroupEditDS(
        codigo: viewModel.codigo,
        number: viewModel.number,
        description: viewModel.description,
        startCourse: viewModel.startCourse,
        endCourse: viewModel.endCourse,
        localCourse: viewModel.localCourse,
        urlFolder: viewModel.urlFolder,
        urlPhoto: viewModel.urlPhoto,
        moduleRef: viewModel.moduleRef,
        workerRefMap: viewModel.workerRefMap,
        opened: viewModel.opened,
        success: viewModel.success,
        arquived: viewModel.arquived,
        isCreateOrUpdate: viewModel.isCreateOrUpdate,
        onCreate: viewModel.onCreate,
        onUpdate: viewModel.onUpdate,
        onEditPop: viewModel.onEditPop,
        onSetWorkerTheGroupSyncGroupAction:
            viewModel.onSetWorkerTheGroupSyncGroupAction,
        workerList: viewModel.workerList,
      ),
    );
  }
}
