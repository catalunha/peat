import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/actions/worker_action.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/module/module_edit_ds.dart';
import 'package:peat/uis/worker/worker_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String sispat;
  String displayName;
  String activity;
  String company;
  bool arquived;
  String plataformIdOnBoard;
  List<String> moduleIdList;
  bool isCreateOrUpdate;
  Function(String, String, String, String) onCreate;
  Function(String, String, String, String, bool) onUpdate;
  ViewModel();
  ViewModel.build({
    @required this.sispat,
    @required this.displayName,
    @required this.activity,
    @required this.company,
    @required this.arquived,
    @required this.plataformIdOnBoard,
    @required this.moduleIdList,
    @required this.isCreateOrUpdate,
    @required this.onCreate,
    @required this.onUpdate,
  }) : super(equals: [
          sispat,
          displayName,
          activity,
          company,
          arquived,
          plataformIdOnBoard,
          moduleIdList,
          isCreateOrUpdate,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        sispat: state.workerState.workerCurrent.sispat,
        displayName: state.workerState.workerCurrent.displayName,
        activity: state.workerState.workerCurrent.activity,
        company: state.workerState.workerCurrent.company,
        arquived: state.workerState.workerCurrent?.arquived ?? false,
        plataformIdOnBoard: state.workerState.workerCurrent.plataformIdOnBoard,
        moduleIdList: state.workerState.workerCurrent?.moduleIdList ?? [],
        isCreateOrUpdate: state.moduleState.moduleCurrent?.id == null,
        onCreate: (String sispat, String displayName, String activity,
            String company) {
          dispatch(SetDocWorkerCurrentAsyncWorkerAction(
            sispat: sispat,
            displayName: displayName,
            activity: activity,
            company: company,
            arquived: false,
          ));
          dispatch(NavigateAction.pop());
        },
        onUpdate: (String sispat, String displayName, String activity,
            String company, bool arquived) {
          dispatch(SetDocWorkerCurrentAsyncWorkerAction(
            sispat: sispat,
            displayName: displayName,
            activity: activity,
            company: company,
            arquived: arquived,
          ));
          dispatch(NavigateAction.pop());
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
        arquived: viewModel.arquived,
        isCreateOrUpdate: viewModel.isCreateOrUpdate,
        onCreate: viewModel.onCreate,
        onUpdate: viewModel.onUpdate,
      ),
    );
  }
}
