import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/actions/group_action.dart';
import 'package:peat/actions/module_action.dart';
import 'package:peat/models/module_model.dart';

import 'package:peat/states/app_state.dart';
import 'package:peat/uis/module/module_select_ds.dart';
import 'package:peat/uis/plataform/plataform_onboard_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<ModuleModel> moduleList;
  Function(String) onSetModuleTheGroup;
  ViewModel();
  ViewModel.build({
    @required this.moduleList,
    @required this.onSetModuleTheGroup,
  }) : super(equals: [
          moduleList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        moduleList: state.moduleState.moduleList,
        onSetModuleTheGroup: (String id) {
          print('id:$id');
          dispatch(SetModuleTheGroupSyncGroupAction(id: id));
          dispatch(NavigateAction.pop());
        },
      );
}

class ModuleSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) => store.dispatch(GetDocsModuleListAsyncModuleAction()),
      builder: (context, viewModel) => ModuleSelectDS(
        moduleList: viewModel.moduleList,
        onSetModuleTheGroup: viewModel.onSetModuleTheGroup,
      ),
    );
  }
}
