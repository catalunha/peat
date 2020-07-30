import 'package:flutter/material.dart';
import 'package:peat/models/group_model.dart';
import 'package:peat/models/worker_model.dart';

class WorkerSelectDS extends StatefulWidget {
  final List<WorkerModel> workerListClean;
  final GroupModel groupCurrent;
  final Function(String, bool) onSetWorkerTheGroup;

  const WorkerSelectDS({
    Key key,
    this.groupCurrent,
    this.onSetWorkerTheGroup,
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
              selected: widget.groupCurrent.workerIdList != null
                  ? widget.groupCurrent.workerIdList.contains(worker.id)
                  : false,
              title: Text('${worker.displayName} ${worker.id}'),
              subtitle: Text('${worker.sispat}'),
              onTap: () {
                widget.onSetWorkerTheGroup(
                    worker.id,
                    !(widget.groupCurrent.workerIdList != null
                        ? widget.groupCurrent.workerIdList.contains(worker.id)
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

/*
class WorkerSelectDS extends StatelessWidget {
  final List<WorkerModel> workerList;
  final GroupModel groupCurrent;
  final Function(String) onSetWorkerTheGroup;
  // bool _selected=false;
  WorkerSelectDS({
    Key key,
    this.workerList,
    this.onSetWorkerTheGroup,
    this.groupCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 300.0,
        width: 400.0,
        child: ListView.builder(
          itemCount: workerList.length,
          itemBuilder: (context, index) {
            final worker = workerList[index];
            return ListTile(
              selected: groupCurrent.workerIdList != null
                  ? groupCurrent.workerIdList.contains(worker.id)
                  : false,
              title: Text('${worker.displayName}'),
              subtitle: Text('${worker.sispat}'),
              onTap: () {
                onSetWorkerTheGroup(worker.id);
              },
            );
          },
        ),
      ),
    );
  }
}
*/
