import 'package:peat/states/logged_state.dart';
import 'package:peat/states/plataform_state.dart';
import 'package:peat/states/user_state.dart';

class AppState {
  final LoggedState loggedState;
  final UserState userState;
  final PlataformState plataformState;

  AppState({
    this.loggedState,
    this.userState,
    this.plataformState,
  });

  static AppState initialState() => AppState(
        loggedState: LoggedState.initialState(),
        userState: UserState.initialState(),
        plataformState: PlataformState.initialState(),
      );
  AppState copyWith({
    LoggedState loggedState,
    UserState userState,
    PlataformState plataformState,
  }) =>
      AppState(
        loggedState: loggedState ?? this.loggedState,
        userState: userState ?? this.userState,
        plataformState: plataformState ?? this.plataformState,
      );
  @override
  int get hashCode =>
      loggedState.hashCode ^ userState.hashCode ^ plataformState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          loggedState == other.loggedState &&
          userState == other.userState &&
          plataformState == other.plataformState &&
          runtimeType == other.runtimeType;
}
