import 'package:flutter/material.dart';
import 'package:peat/conectors/worker/worker_ordering.dart';
import 'package:peat/models/module_model.dart';
import 'package:peat/models/plataform_model.dart';
import 'package:peat/models/worker_model.dart';

class WorkerListAllDS extends StatelessWidget {
  final List<WorkerModel> workerList;
  final List<PlataformModel> plataformList;
  final List<ModuleModel> moduleList;

  final Function(String) onArquivedFalse;
  final Function(String) onModuleIdListNull;
  const WorkerListAllDS({
    Key key,
    this.workerList,
    this.plataformList,
    this.moduleList,
    this.onArquivedFalse,
    this.onModuleIdListNull,
  }) : super(key: key);
  String plataformIdCodigo(String plataformId) {
    String _return;
    if (plataformId != null) {
      PlataformModel plataformModel =
          plataformList.firstWhere((element) => element.id == plataformId);
      _return = plataformModel.codigo;
    }
    return _return;
  }

  String moduleIdData(List<dynamic> moduleIdList) {
    String _return = '';

    if (moduleIdList != null && moduleIdList.isNotEmpty) {
      moduleIdList.forEach((moduleId) {
        ModuleModel moduleModel = moduleList
            .firstWhere((element) => element.id == moduleId.toString());
        _return +=
            '\n${moduleModel.codigo} || ${moduleId.toString().substring(0, 5)}';
      });
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
                'id:${worker.id.substring(0, 5)}\nSISPAT: ${worker.sispat}\nEmpresa: ${worker.company}\nFunção: ${worker.activity}\nPlataforma OnBoard: ${plataformIdCodigo(worker.plataformIdOnBoard)}\nModulos: ${moduleIdData(worker.moduleIdList)}'),
            onTap: () {
              onArquivedFalse(worker.id);
            },
            trailing: IconButton(
              icon: Icon(Icons.delete_sweep),
              onPressed: () => onModuleIdListNull(worker.id),
            ),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     onEditWorkerCurrent(null);
      //   },
      // ),
    );
  }
}
