import 'package:peat/states/logged_state.dart';
import 'package:peat/states/user_state.dart';

class AppState {
  final LoggedState loggedState;
  final UserState userState;

  AppState({
    this.loggedState,
    this.userState,
  });

  static AppState initialState() => AppState(
        loggedState: LoggedState.initialState(),
        userState: UserState.initialState(),
      );
  AppState copyWith({
    LoggedState loggedState,
    UserState userState,
  }) =>
      AppState(
        loggedState: loggedState ?? this.loggedState,
        userState: userState ?? this.userState,
      );
  @override
  int get hashCode => loggedState.hashCode ^ userState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          loggedState == other.loggedState &&
          userState == other.userState &&
          runtimeType == other.runtimeType;
}
