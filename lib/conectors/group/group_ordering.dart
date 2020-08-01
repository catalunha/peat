import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:peat/actions/group_action.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/states/types_states.dart';
import 'package:peat/uis/group/group_ordering_ds.dart';

class ViewModel extends BaseModel<AppState> {
  GroupOrder groupOrder;
  Function(GroupOrder) onSelectOrder;
  ViewModel();
  ViewModel.build({
    @required this.groupOrder,
    @required this.onSelectOrder,
  }) : super(equals: [
          groupOrder,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        groupOrder: state.groupState.groupOrder,
        onSelectOrder: (GroupOrder groupOrder) {
          dispatch(
            SetGroupOrderSyncUserAction(
              groupOrder,
            ),
          );
        },
      );
}

class GroupOrdering extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (BuildContext context, ViewModel viewModel) => GroupOrderingDS(
        groupOrder: viewModel.groupOrder,
        onSelectOrder: viewModel.onSelectOrder,
      ),
    );
  }
}
