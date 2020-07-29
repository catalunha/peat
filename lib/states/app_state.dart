import 'package:peat/states/group_state.dart';
import 'package:peat/states/logged_state.dart';
import 'package:peat/states/module_state.dart';
import 'package:peat/states/plataform_state.dart';
import 'package:peat/states/user_state.dart';
import 'package:peat/states/worker_state.dart';

class AppState {
  final LoggedState loggedState;
  final UserState userState;
  final PlataformState plataformState;
  final ModuleState moduleState;
  final WorkerState workerState;
  final GroupState groupState;

  AppState({
    this.loggedState,
    this.userState,
    this.plataformState,
    this.moduleState,
    this.workerState,
    this.groupState,
  });

  static AppState initialState() => AppState(
        loggedState: LoggedState.initialState(),
        userState: UserState.initialState(),
        plataformState: PlataformState.initialState(),
        moduleState: ModuleState.initialState(),
        workerState: WorkerState.initialState(),
        groupState: GroupState.initialState(),
      );
  AppState copyWith({
    LoggedState loggedState,
    UserState userState,
    PlataformState plataformState,
    ModuleState moduleState,
    WorkerState workerState,
    GroupState groupState,
  }) =>
      AppState(
        loggedState: loggedState ?? this.loggedState,
        userState: userState ?? this.userState,
        plataformState: plataformState ?? this.plataformState,
        moduleState: moduleState ?? this.moduleState,
        workerState: workerState ?? this.workerState,
        groupState: groupState ?? this.groupState,
      );
  @override
  int get hashCode =>
      workerState.hashCode ^
      loggedState.hashCode ^
      userState.hashCode ^
      plataformState.hashCode ^
      moduleState.hashCode ^
      groupState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          groupState == other.groupState &&
          workerState == other.workerState &&
          loggedState == other.loggedState &&
          userState == other.userState &&
          plataformState == other.plataformState &&
          moduleState == other.moduleState &&
          runtimeType == other.runtimeType;
}
