import 'package:flutter/material.dart';
import 'package:peat/conectors/worker/worker_ordering.dart';
import 'package:peat/models/module_model.dart';
import 'package:peat/models/worker_model.dart';

class WorkerListDS extends StatelessWidget {
  final List<WorkerModel> workerList;
  final Function(String) onEditWorkerCurrent;

  const WorkerListDS({
    Key key,
    this.workerList,
    this.onEditWorkerCurrent,
  }) : super(key: key);

  String moduleRefMapData(Map<String, ModuleModel> moduleRefMap) {
    String _return = '';
    if (moduleRefMap != null && moduleRefMap.isNotEmpty)
      for (var moduleRef in moduleRefMap.entries) {
        _return = _return + '\n${moduleRef.value.codigo} || ${moduleRef.value}';
      }
    return _return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${workerList.length} trabalhadores'),
        actions: [WorkerOrdering()],
      ),
      body: ListView.builder(
        itemCount: workerList.length,
        itemBuilder: (context, index) {
          final worker = workerList[index];
          return ListTile(
            selected: worker.arquived,
            title: Text('${worker.displayName}'),
            subtitle: Text(
                'SISPAT: ${worker.sispat}\nEmpresa: ${worker.company}\nFunção: ${worker.activity}\nPlataforma OnBoard: ${worker.plataformRef?.codigo}\nModulos: ${moduleRefMapData(worker.moduleRefMap)}\nworkerModel: $worker\n'),
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
