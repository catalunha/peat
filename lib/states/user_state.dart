import 'package:meta/meta.dart';
import 'package:peat/models/user_model.dart';
import 'package:peat/states/types_states.dart';

@immutable
class UserState {
  final List<UserModel> userList;
  final UserOrder userOrder;
  // final UserModel currentUserModel;
  // final List<UserModel> filteredUserModel;
  // final List<UserModel> selectedUserModel;
  UserState({
    this.userList,
    // this.currentUserModel,
    this.userOrder,
    // this.filteredUserModel,
    // this.selectedUserModel,
  });

  factory UserState.initialState() {
    return UserState(
      userList: [],
      // currentUserModel: null,
      // filteredUserModel: [],
      // selectedUserModel: [],
      userOrder: UserOrder.displayName,
    );
  }
  UserState copyWith({
    List<UserModel> userList,
    // UserModel currentUserModel,
    // List<UserModel> filteredUserModel,
    // List<UserModel> selectedUserModel,
    UserOrder userOrder,
  }) {
    return UserState(
      userList: userList ?? this.userList,
      // currentUserModel: currentUserModel ?? this.currentUserModel,
      userOrder: userOrder ?? this.userOrder,
      // filteredUserModel: filteredUserModel ?? this.filteredUserModel,
      // selectedUserModel: selectedUserModel ?? this.selectedUserModel,
    );
  }

  @override
  int get hashCode =>
      // currentUserModel.hashCode ^
      userOrder.hashCode ^
      // filteredUserModel.hashCode ^
      // selectedUserModel.hashCode ^
      userList.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserState &&
          // currentUserModel == other.currentUserModel &&
          userOrder == other.userOrder &&
          // filteredUserModel == other.filteredUserModel &&
          // selectedUserModel == other.selectedUserModel;
          userList == other.userList &&
          runtimeType == other.runtimeType;

  // @override
  // String toString() {
  //   return 'UsersState{UserModel:$currentUserModel,allUserModel:$allUserModel,UsersFilter:$UserOrder,filteredUserModel:$filteredUserModel}';
  // }
}
