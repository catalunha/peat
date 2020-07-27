import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:peat/actions/logged_action.dart';
import 'package:peat/actions/plataform_action.dart';
import 'package:peat/models/plataform_model.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/user/user_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String email;
  String displayName;
  String sispat;
  String plataformOnBoard;
  dynamic dateTimeOnBoard;

  Function(String, String, dynamic) onUpdate;
  ViewModel();
  ViewModel.build({
    @required this.email,
    @required this.displayName,
    @required this.sispat,
    @required this.plataformOnBoard,
    @required this.dateTimeOnBoard,
    @required this.onUpdate,
  }) : super(equals: [
          email,
          displayName,
          sispat,
          plataformOnBoard,
          dateTimeOnBoard,
        ]);

  String _plataformOnBoard() {
    String _return;
    PlataformModel plataformModel;
    if (state.loggedState.userModelLogged?.plataformIdOnBoard != null) {
      plataformModel = state.plataformState.plataformList.firstWhere(
          (element) =>
              element.id ==
              state.loggedState.userModelLogged.plataformIdOnBoard);
      _return = plataformModel.codigo;
    }

    return _return;
  }

  @override
  ViewModel fromStore() => ViewModel.build(
        email: state.loggedState.userModelLogged?.email ?? '',
        displayName: state.loggedState.userModelLogged?.displayName ?? '',
        sispat: state.loggedState.userModelLogged?.sispat ?? '',
        plataformOnBoard: _plataformOnBoard(),
        dateTimeOnBoard: state.loggedState.userModelLogged?.dateTimeOnBoard,
        onUpdate: (String displayName, String sispat, dynamic dateTimeOnBoard) {
          print(
              '$displayName - $sispat - $plataformOnBoard - $dateTimeOnBoard');
          dispatch(
            SetDocUserModelLoggedAction(
              displayName: displayName,
              sispat: sispat,
              plataformIdOnBoard:
                  state.loggedState.userModelLogged?.plataformIdOnBoard,
              dateTimeOnBoard: dateTimeOnBoard,
            ),
          );
          dispatch(NavigateAction.pop());
        },
      );
}

class UserEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) =>
          store.dispatch(GetDocsPlatatormListAsyncPlataformAction()),
      builder: (BuildContext context, ViewModel viewModel) => UserEditDS(
        email: viewModel.email,
        displayName: viewModel.displayName,
        sispat: viewModel.sispat,
        plataformOnBoard: viewModel.plataformOnBoard,
        dateTimeOnBoard: viewModel.dateTimeOnBoard,
        onUpdate: viewModel.onUpdate,
      ),
    );
  }
}
