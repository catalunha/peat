import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/actions/module_action.dart';
import 'package:peat/models/module_model.dart';
import 'package:peat/routes.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/module/module_list_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<ModuleModel> moduleList;
  Function(String) onEditModuleCurrent;
  ViewModel();
  ViewModel.build({
    @required this.moduleList,
    @required this.onEditModuleCurrent,
  }) : super(equals: [
          moduleList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        moduleList: state.moduleState.moduleList,
        onEditModuleCurrent: (String id) {
          dispatch(SetModuleCurrentSyncModuleAction(id));
          dispatch(NavigateAction.pushNamed(Routes.moduleEdit));
        },
      );
}

class ModuleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) => store.dispatch(GetDocsModuleListAsyncModuleAction()),
      builder: (context, viewModel) => ModuleListDS(
        moduleList: viewModel.moduleList,
        onEditModuleCurrent: viewModel.onEditModuleCurrent,
      ),
    );
  }
}
