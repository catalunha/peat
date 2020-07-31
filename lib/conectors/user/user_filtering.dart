import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/states/types_states.dart';
import 'package:peat/uis/user/user_filtering_ds.dart';

class ViewModel extends BaseModel<AppState> {
  UserFilter userFilter;
  Function(UserFilter) onSelectedFilter;
  ViewModel();
  ViewModel.build({
    @required this.userFilter,
    @required this.onSelectedFilter,
  }) : super(equals: [
          userFilter,
        ]);
  @override
  ViewModel fromStore() => ViewModel.build(
        userFilter: state.userState.userFilter,
        onSelectedFilter: (UserFilter userFilter) {},
      );
}

class UserFiltering extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      debug: this,
      model: ViewModel(),
      builder: (BuildContext context, ViewModel viewModel) => UserFilteringDS(
        userFilter: viewModel.userFilter,
        onSelectedFilter: viewModel.onSelectedFilter,
      ),
    );
  }
}
