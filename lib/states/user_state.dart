import 'package:meta/meta.dart';
import 'package:peat/models/user_model.dart';

@immutable
class UserState {
  // final UserModel currentUserModel;
  final List<UserModel> userList;
  // final List<UserModel> filteredUserModel;
  // final List<UserModel> selectedUserModel;
  // final UserFilter usersFilter;
  UserState({
    this.userList,
    // this.currentUserModel,
    // this.usersFilter,
    // this.filteredUserModel,
    // this.selectedUserModel,
  });

  factory UserState.initialState() {
    return UserState(
      userList: [],
      // currentUserModel: null,
      // filteredUserModel: [],
      // selectedUserModel: [],
      // usersFilter: UserFilter.all,
    );
  }
  UserState copyWith({
    List<UserModel> userList,
    // UserModel currentUserModel,
    // List<UserModel> filteredUserModel,
    // List<UserModel> selectedUserModel,
    // UserFilter usersFilter,
  }) {
    return UserState(
      userList: userList ?? this.userList,
      // currentUserModel: currentUserModel ?? this.currentUserModel,
      // usersFilter: usersFilter ?? this.usersFilter,
      // filteredUserModel: filteredUserModel ?? this.filteredUserModel,
      // selectedUserModel: selectedUserModel ?? this.selectedUserModel,
    );
  }

  @override
  int get hashCode =>
      // currentUserModel.hashCode ^
      // usersFilter.hashCode ^
      // filteredUserModel.hashCode ^
      // selectedUserModel.hashCode ^
      userList.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserState &&
          // currentUserModel == other.currentUserModel &&
          // usersFilter == other.usersFilter &&
          // filteredUserModel == other.filteredUserModel &&
          // selectedUserModel == other.selectedUserModel;
          userList == other.userList &&
          runtimeType == other.runtimeType;

  // @override
  // String toString() {
  //   return 'UsersState{UserModel:$currentUserModel,allUserModel:$allUserModel,UsersFilter:$UserFilter,filteredUserModel:$filteredUserModel}';
  // }
}
