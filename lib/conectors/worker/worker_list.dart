import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/actions/worker_action.dart';
import 'package:peat/models/worker_model.dart';
import 'package:peat/routes.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/worker/worker_list_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<WorkerModel> workerList;
  String workerListIncsv;

  Function(String) onEditWorkerCurrent;
  ViewModel();
  ViewModel.build({
    @required this.workerList,
    @required this.workerListIncsv,
    @required this.onEditWorkerCurrent,
  }) : super(equals: [
          workerList,
          workerListIncsv,
        ]);
  _workerListIncsv() {
    String _return = '';
    List<WorkerModel> _workerList = [];
    _workerList.addAll(state.workerState.workerList);
    _workerList.forEach((element) {
      _return +=
          '${element.sispat};${element.displayName};${element.company};${element.activity};\n';
    });
    return _return;
  }

  @override
  ViewModel fromStore() => ViewModel.build(
        workerList: state.workerState.workerList,
        workerListIncsv: _workerListIncsv(),
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
      onInit: (store) {
        store.dispatch(GetDocsWorkerListAsyncWorkerAction());
      },
      builder: (context, viewModel) => WorkerListDS(
        workerList: viewModel.workerList,
        workerListIncsv: viewModel.workerListIncsv,
        onEditWorkerCurrent: viewModel.onEditWorkerCurrent,
      ),
    );
  }
}
