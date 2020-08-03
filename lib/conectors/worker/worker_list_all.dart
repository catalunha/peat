import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/actions/module_action.dart';
import 'package:peat/actions/worker_action.dart';
import 'package:peat/models/worker_model.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/worker/worker_list_all_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<WorkerModel> workerList;

  Function(String) onArquivedFalse;
  Function(String) onModuleIdListNull;
  ViewModel();
  ViewModel.build({
    @required this.workerList,
    @required this.onArquivedFalse,
    @required this.onModuleIdListNull,
  }) : super(equals: [
          workerList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        workerList: state.workerState.workerList,
        onArquivedFalse: (String id) {
          dispatch(
              SetDocWorkerAsyncWorkerAction(id: id, data: {'arquived': false}));
        },
        onModuleIdListNull: (String id) {
          dispatch(SetDocWorkerAsyncWorkerAction(
              id: id, data: {'moduleRefMap': null}));
        },
      );
}

class WorkerListAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) {
        store.dispatch(GetDocsModuleListAsyncModuleAction());
        store.dispatch(GetDocsWorkerListAllAsyncWorkerAction());
      },
      builder: (context, viewModel) => WorkerListAllDS(
        workerList: viewModel.workerList,
        onArquivedFalse: viewModel.onArquivedFalse,
        onModuleIdListNull: viewModel.onModuleIdListNull,
      ),
    );
  }
}
