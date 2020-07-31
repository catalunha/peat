import 'package:meta/meta.dart';
import 'package:peat/models/worker_model.dart';

@immutable
class WorkerState {
  // final WorkerFilter workerFilter;
  final List<WorkerModel> workerList;
  // final List<WorkerModel> workerSelected;
  // final List<WorkerModel> workerFiltered;
  final WorkerModel workerCurrent;
  final String workerMsg;
  WorkerState({
    this.workerList,
    this.workerCurrent,
    this.workerMsg,
  });
  factory WorkerState.initialState() => WorkerState(
        workerList: <WorkerModel>[],
        workerCurrent: null,
        workerMsg: '',
      );
  WorkerState copyWith({
    List<WorkerModel> workerList,
    WorkerModel workerCurrent,
    String workerMsg,
  }) =>
      WorkerState(
        workerList: workerList ?? this.workerList,
        workerCurrent: workerCurrent ?? this.workerCurrent,
        workerMsg: workerMsg ?? this.workerMsg,
      );
  @override
  int get hashCode =>
      workerList.hashCode ^ workerCurrent.hashCode ^ workerMsg.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkerState &&
          workerMsg == other.workerMsg &&
          workerList == other.workerList &&
          workerCurrent == other.workerCurrent &&
          runtimeType == other.runtimeType;
}
