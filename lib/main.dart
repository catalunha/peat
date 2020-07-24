import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/actions/logged_action.dart';
import 'package:peat/plataform/resources.dart';
import 'package:peat/routes.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/states/types_states.dart';

Store<AppState> _store = Store<AppState>(
  initialState: AppState.initialState(),
  actionObservers: [Log<AppState>.printer()],
  modelObserver: DefaultModelObserver(),
);
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NavigateAction.setNavigatorKey(Keys.navigatorStateKey);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({Key key})
      : store = _store,
        super(key: key) {
    store.dispatch(AuthenticationStatusLoggedAction(
        authenticationStatusLogged: AuthenticationStatusLogged.unInitialized));
    store.dispatch(OnAuthStateChangedLoggedAction());
  }
  @override
  Widget build(BuildContext context) {
    Resources.initialize(Theme.of(context).platform);

    return StoreProvider<AppState>(
      // store: appStore,
      store: store,
      child: MaterialApp(
        title: 'PEAT',
        navigatorKey: Keys.navigatorStateKey,
        initialRoute: Routes.home,
        routes: Routes.routes,
      ),
    );
  }
}
