import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:peat/actions/group_action.dart';
import 'package:peat/models/group_model.dart';
import 'package:peat/routes.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/uis/group/group_list_ds.dart';

class ViewModel extends BaseModel<AppState> {
  List<GroupModel> groupList;
  Function(String) onEditGroupCurrent;
  ViewModel();
  ViewModel.build({
    @required this.groupList,
    @required this.onEditGroupCurrent,
  }) : super(equals: [
          groupList,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        groupList: state.groupState.groupList,
        onEditGroupCurrent: (String id) {
          dispatch(SetGroupCurrentSyncGroupAction(id));
          dispatch(NavigateAction.pushNamed(Routes.groupEdit));
        },
      );
}

class GroupList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      onInit: (store) => store.dispatch(GetDocsGroupListAsyncGroupAction()),
      builder: (context, viewModel) => GroupListDS(
        groupList: viewModel.groupList,
        onEditGroupCurrent: viewModel.onEditGroupCurrent,
      ),
    );
  }
}
