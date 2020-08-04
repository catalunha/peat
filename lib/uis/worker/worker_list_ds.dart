import 'package:flutter/material.dart';
import 'package:peat/conectors/worker/worker_ordering.dart';
import 'package:peat/models/module_model.dart';
import 'package:peat/models/worker_model.dart';
import 'package:clipboard/clipboard.dart';

class WorkerListDS extends StatelessWidget {
  final List<WorkerModel> workerList;
  final String workerListIncsv;
  final Function(String) onEditWorkerCurrent;

  WorkerListDS({
    Key key,
    this.workerList,
    this.onEditWorkerCurrent,
    this.workerListIncsv,
  }) : super(key: key);

  String moduleRefMapData(Map<String, ModuleModel> moduleRefMap) {
    String _return = '';
    if (moduleRefMap != null && moduleRefMap.isNotEmpty)
      for (var moduleRef in moduleRefMap.entries) {
        _return = _return + '\n${moduleRef.value.codigo} || ${moduleRef.value}';
      }
    return _return;
  }

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${workerList.length} trabalhadores'),
        actions: [
          IconButton(
            icon: Icon(Icons.content_paste),
            tooltip: 'Copiar lista em csv. Fazer um CTRL-c.',
            onPressed: () {
              FlutterClipboard.copy(workerListIncsv).then((value) {
                print('copied');
                scaffoldState.currentState.showSnackBar(SnackBar(
                    content:
                        Text('Lista copiada para csv. CTRL-c concluído.')));
              });
            },
          ),
          WorkerOrdering(),
        ],
      ),
      body: ListView.builder(
        itemCount: workerList.length,
        itemBuilder: (context, index) {
          final worker = workerList[index];
          return Card(
            child: ListTile(
              selected: worker.arquived,
              title: Text('${worker.displayName}'),
              subtitle: Text(
                  'SISPAT: ${worker.sispat}\nEmpresa: ${worker.company}\nFunção: ${worker.activity}\nPlataforma OnBoard: ${worker.plataformRef?.codigo}\nModulos: ${moduleRefMapData(worker.moduleRefMap)}\nworkerModel: $worker\n'),
              onTap: () {
                onEditWorkerCurrent(worker.id);
              },
            ),
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
