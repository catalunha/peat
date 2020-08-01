import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:peat/actions/user_action.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/states/types_states.dart';
import 'package:peat/uis/user/user_ordering_ds.dart';

class ViewModel extends BaseModel<AppState> {
  UserOrder userOrder;
  Function(UserOrder) onSelectOrder;
  ViewModel();
  ViewModel.build({
    @required this.userOrder,
    @required this.onSelectOrder,
  }) : super(equals: [
          userOrder,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        userOrder: state.userState.userOrder,
        onSelectOrder: (UserOrder userOrder) {
          dispatch(
            SetUserOrderSyncUserAction(
              userOrder,
            ),
          );
        },
      );
}

class UserOrdering extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (BuildContext context, ViewModel viewModel) => UserOrderingDS(
        userOrder: viewModel.userOrder,
        onSelectOrder: viewModel.onSelectOrder,
      ),
    );
  }
}
