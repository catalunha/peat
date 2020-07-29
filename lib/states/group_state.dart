import 'package:meta/meta.dart';
import 'package:peat/models/group_model.dart';

@immutable
class GroupState {
  // final PlataformFilter groupFilter;
  final List<GroupModel> groupList;
  // final List<GroupModel> groupSelected;
  // final List<GroupModel> groupFiltered;
  final GroupModel groupCurrent;
  GroupState({
    this.groupList,
    this.groupCurrent,
  });
  factory GroupState.initialState() => GroupState(
        groupList: <GroupModel>[],
        groupCurrent: null,
      );
  GroupState copyWith({
    List<GroupModel> groupList,
    GroupModel groupCurrent,
  }) =>
      GroupState(
        groupList: groupList ?? this.groupList,
        groupCurrent: groupCurrent ?? this.groupCurrent,
      );
  @override
  int get hashCode => groupList.hashCode ^ groupCurrent.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupState &&
          runtimeType == other.runtimeType &&
          groupList == other.groupList &&
          groupCurrent == other.groupCurrent;
}
