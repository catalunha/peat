import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/plataform/plataform_edit_ds.dart';

class ViewModel extends BaseModel<AppState> {
  String codigo;
  String description;
  bool arquived;
  bool isCreateOrUpdate;
  Function(String, String) onCreate;
  Function(String, String, bool) onUpdate;
  ViewModel();
  ViewModel.build({
    @required this.codigo,
    @required this.description,
    @required this.arquived,
    @required this.isCreateOrUpdate,
    @required this.onCreate,
    @required this.onUpdate,
  }) : super(equals: [
          codigo,
          description,
          arquived,
          isCreateOrUpdate,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        isCreateOrUpdate: state.plataformState.plataformCurrent.id == null,
        codigo: state.plataformState.plataformCurrent.codigo,
        description: state.plataformState.plataformCurrent.description,
        arquived: state.plataformState.plataformCurrent?.arquived ?? false,
        onCreate: (String codigo, String description) {
          print('PlataformEdit.onCreate');
          print('$codigo | $description');
        },
        onUpdate: (String codigo, String description, bool arquived) {
          print('PlataformEdit.onUpdate');
          print('$codigo | $description | $arquived');
        },
      );
}

class PlataformEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (context, viewModel) => PlataformEditDS(
        isCreateOrUpdate: viewModel.isCreateOrUpdate,
        codigo: viewModel.codigo,
        description: viewModel.description,
        arquived: viewModel.arquived,
        onCreate: viewModel.onCreate,
        onUpdate: viewModel.onUpdate,
      ),
    );
  }
}
