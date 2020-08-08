import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:peat/actions/logged_action.dart';
import 'package:peat/actions/plataform_action.dart';
import 'package:peat/models/plataform_model.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/user/user_logged_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String email;
  String displayName;
  String sispat;
  String plataformOnBoard;
  dynamic dateTimeOnBoard;

  Function(dynamic, bool) onUpdate;
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
    if (state.loggedState.userModelLogged?.plataformRef != null) {
      plataformModel = state.plataformState.plataformList.firstWhere(
          (element) =>
              element.id == state.loggedState.userModelLogged.plataformRef.id);
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
        onUpdate: (dynamic dateTimeOnBoard, bool desembarcar) {
          if (desembarcar) {
            dispatch(SetUserInPlataformSyncLoggedAction(plataformModel: null));
            dispatch(UpdateDocUserModelAsyncLoggedAction(
              dateTimeOnBoard: null,
            ));
          } else {
            dispatch(
              UpdateDocUserModelAsyncLoggedAction(
                dateTimeOnBoard: dateTimeOnBoard,
              ),
            );
          }
          dispatch(NavigateAction.pop());
        },
      );
}

class UserLoggedEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) =>
          store.dispatch(GetDocsPlataformListAsyncPlataformAction()),
      builder: (BuildContext context, ViewModel viewModel) => UserLoggedEditDS(
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
