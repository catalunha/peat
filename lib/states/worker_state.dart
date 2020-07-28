import 'package:meta/meta.dart';
import 'package:peat/models/worker_model.dart';

@immutable
class WorkerState {
  // final WorkerFilter workerFilter;
  final List<WorkerModel> workerList;
  // final List<WorkerModel> workerSelected;
  // final List<WorkerModel> workerFiltered;
  final WorkerModel workerCurrent;
  WorkerState({
    this.workerList,
    this.workerCurrent,
  });
  factory WorkerState.initialState() => WorkerState(
        workerList: <WorkerModel>[],
        workerCurrent: null,
      );
  WorkerState copyWith({
    List<WorkerModel> workerList,
    WorkerModel workerCurrent,
  }) =>
      WorkerState(
        workerList: workerList ?? this.workerList,
        workerCurrent: workerCurrent ?? this.workerCurrent,
      );
  @override
  int get hashCode => workerList.hashCode ^ workerCurrent.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkerState &&
          workerList == other.workerList &&
          workerCurrent == other.workerCurrent &&
          runtimeType == other.runtimeType;
}
