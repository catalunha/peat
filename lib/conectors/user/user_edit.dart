import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:peat/actions/logged_action.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/user/user_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String displayName;
  String sispat;
  Function(String, String) onUpdate;
  ViewModel();
  ViewModel.build({
    @required this.displayName,
    @required this.sispat,
    @required this.onUpdate,
  }) : super(equals: [
          displayName,
          sispat,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        displayName: state.loggedState.userModelLogged?.displayName ?? '',
        sispat: state.loggedState.userModelLogged?.sispat ?? '',
        onUpdate: (String displayName, String sispat) {
          print('$displayName - $sispat');
          dispatch(SetUserModelLoggedAction(
            displayName: displayName,
            sispat: sispat,
          ));
        },
      );
}

class UserEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (BuildContext context, ViewModel viewModel) => UserEditDS(
        displayName: viewModel.displayName,
        sispat: viewModel.sispat,
        onUpdate: viewModel.onUpdate,
      ),
    );
  }
}
