import 'package:flutter/material.dart';
import 'package:peat/models/worker_model.dart';

class WorkerListDS extends StatelessWidget {
  final List<WorkerModel> workerList;
  final Function(String) onEditWorkerCurrent;

  const WorkerListDS({
    Key key,
    this.workerList,
    this.onEditWorkerCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${workerList.length} trabalhadores'),
      ),
      body: ListView.builder(
        itemCount: workerList.length,
        itemBuilder: (context, index) {
          final worker = workerList[index];
          return ListTile(
            title: Text('${worker.displayName}'),
            subtitle: Text(
                'SISPAT: ${worker.sispat}\nEmpresa: ${worker.company}\nFunção: ${worker.activity}\nPlataforma OnBoard: ${worker.plataformIdOnBoard}\nModulos: ${worker.moduleIdList?.length ?? null}'),
            onTap: () {
              onEditWorkerCurrent(worker.id);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          onEditWorkerCurrent(null);
        },
      ),
    );
  }
}
