import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:peat/actions/worker_action.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/worker/worker_onboard_ds.dart';

class ViewModel extends BaseModel<AppState> {
  bool inBoard;
  String workerMsg;
  bool waiting;
  Function(String, bool) onSetWorkerListOnBoard;
  ViewModel();
  ViewModel.build({
    @required this.inBoard,
    @required this.workerMsg,
    @required this.waiting,
    @required this.onSetWorkerListOnBoard,
  }) : super(equals: [
          inBoard,
          workerMsg,
          waiting,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        inBoard: true,
        waiting: state.wait.isWaiting,
        workerMsg: state.workerState.workerMsg.trim(),
        onSetWorkerListOnBoard: (String workerListOnBoard, bool inBoard) {
          print(
              '$inBoard onSetWorkerListOnBoard: ${workerListOnBoard.trim().split('\n')}');
          dispatch(
            BatchedDocsWorkerListOnBoardAsyncWorkerAction(
              inBoard: inBoard,
              sispatList: workerListOnBoard.trim().split('\n'),
            ),
          );

          dispatch(SetWorkerMsgSyncWorkerAction(null));
        },
      );
}

class WorkerOnBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (BuildContext context, ViewModel viewModel) => WorkerOnBoardDS(
        inBoard: viewModel.inBoard,
        waiting: viewModel.waiting,
        workerMsg: viewModel.workerMsg,
        onSetWorkerListOnBoard: viewModel.onSetWorkerListOnBoard,
      ),
    );
  }
}
