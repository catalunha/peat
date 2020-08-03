import 'package:meta/meta.dart';
import 'package:peat/models/worker_model.dart';
import 'package:peat/states/types_states.dart';

@immutable
class WorkerState {
  final List<WorkerModel> workerList;
  final WorkerOrder workerOrder;
  final WorkerModel workerCurrent;
  final String workerMsg;
  WorkerState({
    this.workerList,
    this.workerOrder,
    this.workerCurrent,
    this.workerMsg,
  });
  factory WorkerState.initialState() => WorkerState(
        workerList: <WorkerModel>[],
        workerOrder: WorkerOrder.displayName,
        workerCurrent: null,
        workerMsg: '',
      );
  WorkerState copyWith({
    List<WorkerModel> workerList,
    WorkerOrder workerOrder,
    WorkerModel workerCurrent,
    String workerMsg,
  }) =>
      WorkerState(
        workerList: workerList ?? this.workerList,
        workerOrder: workerOrder ?? this.workerOrder,
        workerCurrent: workerCurrent ?? this.workerCurrent,
        workerMsg: workerMsg ?? this.workerMsg,
      );
  @override
  int get hashCode =>
      workerList.hashCode ^
      workerCurrent.hashCode ^
      workerMsg.hashCode ^
      workerOrder.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkerState &&
          workerOrder == other.workerOrder &&
          workerMsg == other.workerMsg &&
          workerList == other.workerList &&
          workerCurrent == other.workerCurrent &&
          runtimeType == other.runtimeType;
}
