import 'package:peat/states/logged_state.dart';
import 'package:peat/states/module_state.dart';
import 'package:peat/states/plataform_state.dart';
import 'package:peat/states/user_state.dart';

class AppState {
  final LoggedState loggedState;
  final UserState userState;
  final PlataformState plataformState;
  final ModuleState moduleState;

  AppState({
    this.loggedState,
    this.userState,
    this.plataformState,
    this.moduleState,
  });

  static AppState initialState() => AppState(
        loggedState: LoggedState.initialState(),
        userState: UserState.initialState(),
        plataformState: PlataformState.initialState(),
        moduleState: ModuleState.initialState(),
      );
  AppState copyWith({
    LoggedState loggedState,
    UserState userState,
    PlataformState plataformState,
    ModuleState moduleState,
  }) =>
      AppState(
        loggedState: loggedState ?? this.loggedState,
        userState: userState ?? this.userState,
        plataformState: plataformState ?? this.plataformState,
        moduleState: moduleState ?? this.moduleState,
      );
  @override
  int get hashCode =>
      loggedState.hashCode ^
      userState.hashCode ^
      plataformState.hashCode ^
      moduleState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          loggedState == other.loggedState &&
          userState == other.userState &&
          plataformState == other.plataformState &&
          moduleState == other.moduleState &&
          runtimeType == other.runtimeType;
}
