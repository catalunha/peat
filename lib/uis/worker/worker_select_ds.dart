import 'package:flutter/material.dart';
import 'package:peat/models/worker_model.dart';

class WorkerSelectDS extends StatelessWidget {
  final List<WorkerModel> workerList;
  final Function(String) onSetWorkerTheGroup;

  const WorkerSelectDS({
    Key key,
    this.workerList,
    this.onSetWorkerTheGroup,
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
