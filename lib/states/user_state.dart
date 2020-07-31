import 'package:meta/meta.dart';
import 'package:peat/models/user_model.dart';
import 'package:peat/states/types_states.dart';

@immutable
class UserState {
  // final UserModel currentUserModel;
  final List<UserModel> userList;
  // final List<UserModel> filteredUserModel;
  // final List<UserModel> selectedUserModel;
  final UserFilter userFilter;
  UserState({
    this.userList,
    // this.currentUserModel,
    this.userFilter,
    // this.filteredUserModel,
    // this.selectedUserModel,
  });

  factory UserState.initialState() {
    return UserState(
      userList: [],
      // currentUserModel: null,
      // filteredUserModel: [],
      // selectedUserModel: [],
      userFilter: UserFilter.displayName,
    );
  }
  UserState copyWith({
    List<UserModel> userList,
    // UserModel currentUserModel,
    // List<UserModel> filteredUserModel,
    // List<UserModel> selectedUserModel,
    UserFilter userFilter,
  }) {
    return UserState(
      userList: userList ?? this.userList,
      // currentUserModel: currentUserModel ?? this.currentUserModel,
      userFilter: userFilter ?? this.userFilter,
      // filteredUserModel: filteredUserModel ?? this.filteredUserModel,
      // selectedUserModel: selectedUserModel ?? this.selectedUserModel,
    );
  }

  @override
  int get hashCode =>
      // currentUserModel.hashCode ^
      userFilter.hashCode ^
      // filteredUserModel.hashCode ^
      // selectedUserModel.hashCode ^
      userList.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserState &&
          // currentUserModel == other.currentUserModel &&
          userFilter == other.userFilter &&
          // filteredUserModel == other.filteredUserModel &&
          // selectedUserModel == other.selectedUserModel;
          userList == other.userList &&
          runtimeType == other.runtimeType;

  // @override
  // String toString() {
  //   return 'UsersState{UserModel:$currentUserModel,allUserModel:$allUserModel,UsersFilter:$UserFilter,filteredUserModel:$filteredUserModel}';
  // }
}
