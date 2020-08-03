import 'package:meta/meta.dart';
import 'package:peat/models/group_model.dart';
import 'package:peat/states/types_states.dart';

@immutable
class GroupState {
  final List<GroupModel> groupList;
  final GroupOrder groupOrder;
  final GroupModel groupCurrent;
  GroupState({
    this.groupList,
    this.groupOrder,
    this.groupCurrent,
  });
  factory GroupState.initialState() => GroupState(
        groupList: <GroupModel>[],
        groupOrder: GroupOrder.codigo,
        groupCurrent: null,
      );
  GroupState copyWith({
    List<GroupModel> groupList,
    GroupOrder groupOrder,
    GroupModel groupCurrent,
  }) =>
      GroupState(
        groupList: groupList ?? this.groupList,
        groupOrder: groupOrder ?? this.groupOrder,
        groupCurrent: groupCurrent ?? this.groupCurrent,
      );
  @override
  int get hashCode =>
      groupList.hashCode ^ groupCurrent.hashCode ^ groupOrder.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupState &&
          groupOrder == other.groupOrder &&
          groupList == other.groupList &&
          groupCurrent == other.groupCurrent &&
          runtimeType == other.runtimeType;
}
