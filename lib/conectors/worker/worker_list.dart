import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/actions/worker_action.dart';
import 'package:peat/models/plataform_model.dart';
import 'package:peat/models/worker_model.dart';
import 'package:peat/routes.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/worker/worker_list_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<WorkerModel> workerList;
  List<PlataformModel> plataformList;
  Function(String) onEditWorkerCurrent;
  ViewModel();
  ViewModel.build({
    @required this.workerList,
    @required this.plataformList,
    @required this.onEditWorkerCurrent,
  }) : super(equals: [
          workerList,
          plataformList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        workerList: state.workerState.workerList,
        plataformList: state.plataformState.plataformList,
        onEditWorkerCurrent: (String id) {
          dispatch(SetWorkerCurrentSyncWorkerAction(id));
          dispatch(NavigateAction.pushNamed(Routes.workerEdit));
        },
      );
}

class WorkerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) => store.dispatch(GetDocsWorkerListAsyncWorkerAction()),
      builder: (context, viewModel) => WorkerListDS(
        workerList: viewModel.workerList,
        plataformList: viewModel.plataformList,
        onEditWorkerCurrent: viewModel.onEditWorkerCurrent,
      ),
    );
  }
}