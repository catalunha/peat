import 'package:flutter/material.dart';
import 'package:peat/states/types_states.dart';

class GroupOrderingDS extends StatelessWidget with _GroupOrderingDSComponents {
  final GroupOrder groupOrder;
  final Function(GroupOrder) onSelectOrder;

  GroupOrderingDS({Key key, this.groupOrder, this.onSelectOrder})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<GroupOrder>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      icon: popupIcon(groupOrder),
      tooltip: 'Ordenar grupo por',
      onSelected: (value) => onSelectOrder(value),
      itemBuilder: (context) => <PopupMenuItem<GroupOrder>>[
        PopupMenuItem<GroupOrder>(
          value: GroupOrder.codigo,
          child: Row(
            children: [
              codigoIcon,
              SizedBox(width: 5),
              Text(GroupOrder.codigo.name),
            ],
          ),
        ),
        PopupMenuItem<GroupOrder>(
          value: GroupOrder.number,
          child: Row(
            children: [
              numberIcon,
              SizedBox(width: 5),
              Text(GroupOrder.number.name),
            ],
          ),
        ),
        PopupMenuItem<GroupOrder>(
          value: GroupOrder.startCourse,
          child: Row(
            children: [
              startCourseIcon,
              SizedBox(width: 5),
              Text(GroupOrder.startCourse.name),
            ],
          ),
        ),
        PopupMenuItem<GroupOrder>(
          value: GroupOrder.localCourse,
          child: Row(
            children: [
              localCourseIcon,
              SizedBox(width: 5),
              Text(GroupOrder.localCourse.name),
            ],
          ),
        ),
        PopupMenuItem<GroupOrder>(
          value: GroupOrder.moduleId,
          child: Row(
            children: [
              moduleIdIcon,
              SizedBox(width: 5),
              Text(GroupOrder.moduleId.name),
            ],
          ),
        ),
      ],
    );
  }
}

class _GroupOrderingDSComponents {
  final codigoIcon = Icon(Icons.sort_by_alpha);
  final numberIcon = Icon(Icons.sort_by_alpha);
  final startCourseIcon = Icon(Icons.date_range);
  final localCourseIcon = Icon(Icons.person_pin_circle);
  final moduleIdIcon = Icon(Icons.record_voice_over);
  Icon popupIcon(GroupOrder groupOrder) {
    var icon = codigoIcon;
    if (groupOrder == GroupOrder.number) {
      icon = numberIcon;
    } else if (groupOrder == GroupOrder.startCourse) {
      icon = startCourseIcon;
    } else if (groupOrder == GroupOrder.localCourse) {
      icon = localCourseIcon;
    } else if (groupOrder == GroupOrder.moduleId) {
      icon = moduleIdIcon;
    }
    return icon;
  }
}
