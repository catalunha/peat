import 'package:flutter/material.dart';
import 'package:peat/states/types_states.dart';

class WorkerOrderingDS extends StatelessWidget
    with _WorkerOrderingDSComponents {
  final WorkerOrder workerOrder;
  final Function(WorkerOrder) onSelectOrder;

  WorkerOrderingDS({Key key, this.workerOrder, this.onSelectOrder})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<WorkerOrder>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      icon: popupIcon(workerOrder),
      tooltip: 'Ordenar trabalhador por',
      onSelected: (value) => onSelectOrder(value),
      itemBuilder: (context) => <PopupMenuItem<WorkerOrder>>[
        PopupMenuItem<WorkerOrder>(
          value: WorkerOrder.sispat,
          child: Row(
            children: [
              sispatIcon,
              SizedBox(width: 5),
              Text(WorkerOrder.sispat.name),
            ],
          ),
        ),
        PopupMenuItem<WorkerOrder>(
          value: WorkerOrder.displayName,
          child: Row(
            children: [
              displayNameIcon,
              SizedBox(width: 5),
              Text(WorkerOrder.displayName.name),
            ],
          ),
        ),
        PopupMenuItem<WorkerOrder>(
          value: WorkerOrder.company,
          child: Row(
            children: [
              companyIcon,
              SizedBox(width: 5),
              Text(WorkerOrder.company.name),
            ],
          ),
        ),
        PopupMenuItem<WorkerOrder>(
          value: WorkerOrder.activity,
          child: Row(
            children: [
              activityIcon,
              SizedBox(width: 5),
              Text(WorkerOrder.activity.name),
            ],
          ),
        ),
      ],
    );
  }
}

class _WorkerOrderingDSComponents {
  final sispatIcon = Icon(Icons.format_list_numbered);
  final displayNameIcon = Icon(Icons.sort_by_alpha);
  final companyIcon = Icon(Icons.store_mall_directory);
  final activityIcon = Icon(Icons.snooze);
  Icon popupIcon(WorkerOrder workerOrder) {
    var icon = sispatIcon;
    if (workerOrder == WorkerOrder.displayName) {
      icon = displayNameIcon;
    } else if (workerOrder == WorkerOrder.company) {
      icon = companyIcon;
    } else if (workerOrder == WorkerOrder.activity) {
      icon = activityIcon;
    }
    return icon;
  }
}
