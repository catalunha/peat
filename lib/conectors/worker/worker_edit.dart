import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/actions/worker_action.dart';
import 'package:peat/models/module_model.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/worker/worker_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String sispat;
  String displayName;
  String activity;
  String company;
  bool arquived;
  Map<String, ModuleModel> moduleRefMap;
  bool isCreateOrUpdate;

  Function(String, String, String, String) onCreate;
  Function(String, String, String, String, bool) onUpdate;

  Function(String) onRemoveModuleSyncWorkerAction;
  ViewModel();
  ViewModel.build({
    @required this.sispat,
    @required this.displayName,
    @required this.activity,
    @required this.company,
    @required this.arquived,
    @required this.moduleRefMap,
    @required this.isCreateOrUpdate,
    @required this.onCreate,
    @required this.onUpdate,
    @required this.onRemoveModuleSyncWorkerAction,
  }) : super(equals: [
          sispat,
          displayName,
          activity,
          company,
          arquived,
          moduleRefMap,
          isCreateOrUpdate,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        sispat: state.workerState.workerCurrent.sispat,
        displayName: state.workerState.workerCurrent.displayName,
        activity: state.workerState.workerCurrent.activity,
        company: state.workerState.workerCurrent.company,
        moduleRefMap: state.workerState.workerCurrent.moduleRefMap,
        arquived: state.workerState.workerCurrent?.arquived ?? false,
        isCreateOrUpdate: state.workerState.workerCurrent?.id == null,
        onCreate: (String sispat, String displayName, String activity,
            String company) {
          dispatch(CreateDocWorkerCurrentAsyncWorkerAction(
            sispat: sispat,
            displayName: displayName,
            activity: activity,
            company: company,
          ));
          dispatch(NavigateAction.pop());
        },
        onUpdate: (String sispat, String displayName, String activity,
            String company, bool arquived) {
          dispatch(UpdateDocWorkerCurrentAsyncWorkerAction(
            sispat: sispat,
            displayName: displayName,
            activity: activity,
            company: company,
            arquived: arquived,
          ));
          dispatch(NavigateAction.pop());
        },
        onRemoveModuleSyncWorkerAction: (String moduleId) {
          dispatch(RemoveModuleSyncWorkerAction(moduleId));
        },
      );
}

class WorkerEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => WorkerEditDS(
        sispat: viewModel.sispat,
        displayName: viewModel.displayName,
        activity: viewModel.activity,
        company: viewModel.company,
        moduleRefMap: viewModel.moduleRefMap,
        arquived: viewModel.arquived,
        onRemoveModuleSyncWorkerAction:
            viewModel.onRemoveModuleSyncWorkerAction,
        isCreateOrUpdate: viewModel.isCreateOrUpdate,
        onCreate: viewModel.onCreate,
        onUpdate: viewModel.onUpdate,
      ),
    );
  }
}
