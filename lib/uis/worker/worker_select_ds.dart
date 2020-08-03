import 'package:flutter/material.dart';
import 'package:peat/models/group_model.dart';
import 'package:peat/models/worker_model.dart';

class WorkerSelectDS extends StatefulWidget {
  final List<WorkerModel> workerListClean;
  final GroupModel groupCurrent;
  final Function(WorkerModel, bool) onSetWorkerTheGroupSyncGroupAction;

  const WorkerSelectDS({
    Key key,
    this.groupCurrent,
    this.onSetWorkerTheGroupSyncGroupAction,
    this.workerListClean,
  }) : super(key: key);
  @override
  _WorkerSelectDSState createState() => _WorkerSelectDSState();
}

class _WorkerSelectDSState extends State<WorkerSelectDS> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 300.0,
        width: 400.0,
        child: ListView.builder(
          itemCount: widget.workerListClean.length,
          itemBuilder: (context, index) {
            final worker = widget.workerListClean[index];

            return ListTile(
              selected: widget.groupCurrent.workerRefMap != null
                  ? widget.groupCurrent.workerRefMap.containsKey(worker.id)
                  : false,
              title: Text('${worker.displayName} ${worker.id}'),
              subtitle: Text('${worker.sispat}'),
              onTap: () {
                widget.onSetWorkerTheGroupSyncGroupAction(
                    worker,
                    !(widget.groupCurrent.workerRefMap != null
                        ? widget.groupCurrent.workerRefMap
                            .containsKey(worker.id)
                        : false));
                setState(() {});
              },
            );
          },
        ),
      ),
    );
  }
}
