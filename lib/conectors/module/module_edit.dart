import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/actions/module_action.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/module/module_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String codigo;
  String description;
  String urlFolder;
  bool arquived;
  bool isCreateOrUpdate;
  Function(String, String, String) onCreate;
  Function(String, String, String, bool) onUpdate;
  ViewModel();
  ViewModel.build({
    @required this.codigo,
    @required this.description,
    @required this.urlFolder,
    @required this.arquived,
    @required this.isCreateOrUpdate,
    @required this.onCreate,
    @required this.onUpdate,
  }) : super(equals: [
          codigo,
          description,
          urlFolder,
          arquived,
          isCreateOrUpdate,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        isCreateOrUpdate: state.moduleState.moduleCurrent.id == null,
        codigo: state.moduleState.moduleCurrent.codigo,
        description: state.moduleState.moduleCurrent.description,
        urlFolder: state.moduleState.moduleCurrent.urlFolder,
        arquived: state.moduleState.moduleCurrent?.arquived ?? false,
        onCreate: (String codigo, String description, String urlFolder) {
          print('ModuleEdit.onCreate');
          print('$codigo | $description');
          dispatch(SetDocModuleCurrentAsyncModuleAction(
            codigo: codigo,
            description: description,
            urlFolder: urlFolder,
            arquived: false,
          ));
          dispatch(NavigateAction.pop());
        },
        onUpdate: (String codigo, String description, String urlFolder,
            bool arquived) {
          print('ModuleEdit.onUpdate');
          print('$codigo | $description | $arquived');
          dispatch(SetDocModuleCurrentAsyncModuleAction(
            codigo: codigo,
            description: description,
            urlFolder: urlFolder,
            arquived: arquived,
          ));
          dispatch(NavigateAction.pop());
        },
      );
}

class ModuleEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => ModuleEditDS(
        isCreateOrUpdate: viewModel.isCreateOrUpdate,
        codigo: viewModel.codigo,
        description: viewModel.description,
        urlFolder: viewModel.urlFolder,
        arquived: viewModel.arquived,
        onCreate: viewModel.onCreate,
        onUpdate: viewModel.onUpdate,
      ),
    );
  }
}
