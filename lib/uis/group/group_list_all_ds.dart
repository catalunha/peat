import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peat/conectors/group/group_ordering.dart';
import 'package:peat/models/group_model.dart';
import 'package:peat/models/module_model.dart';
import 'package:peat/models/plataform_model.dart';
import 'package:peat/models/user_model.dart';
import 'package:peat/models/worker_model.dart';
import 'package:url_launcher/url_launcher.dart';

class GroupListAllDS extends StatefulWidget {
  final List<GroupModel> groupList;
  // final List<ModuleModel> moduleList;
  // final List<PlataformModel> plataformList;
  // final UserModel userModel;
  // final List<WorkerModel> workerList;

  final Function(String) onArquivedFalse;

  const GroupListAllDS({
    Key key,
    this.groupList,
    this.onArquivedFalse,
    // this.moduleList,
    // this.plataformList,
    // this.userModel,
    // this.workerList,
  }) : super(key: key);

  @override
  _GroupListAllDSState createState() => _GroupListAllDSState();
}

class _GroupListAllDSState extends State<GroupListAllDS> {
  String workerRefMapData(Map<String, WorkerModel> workerRefMap) {
    String _return = '';
    List<WorkerModel> workerModelList = workerRefMap.values.toList();

    workerModelList.sort((a, b) => a.displayName.compareTo(b.displayName));
    for (var workerRef in workerModelList) {
      _return = _return +
          '\n${workerRef.displayName} || ${workerRef.id.substring(0, 5)}';
    }
    return _return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${widget.groupList.length} grupos'),
        actions: [GroupOrdering()],
      ),
      body: ListView.builder(
        itemCount: widget.groupList.length,
        itemBuilder: (context, index) {
          final group = widget.groupList[index];
          return Card(
            child: Column(
              children: [
                ListTile(
                  selected: group.arquived,
                  title: Text('${group.codigo}'),
                  subtitle: Text(
                      '\nid: ${group.id.substring(0, 5)}\nnumber: ${group.number}\ndescription: ${group.description}\nstartCourse: ${DateFormat('yyyy-MM-dd HH:mm').format(group.startCourse)}\nendCourse: ${DateFormat('yyyy-MM-dd HH:mm').format(group.endCourse)}\nlocalCourse: ${group.localCourse}\nurlFolder: ${group.urlFolder}\nurlPhoto: ${group.urlPhoto}\nopened: ${group.opened}\nsuccess: ${group.success}\narquived: ${group.arquived}\nuserId: ${group.userRef.id}\nplataformId: ${group.userRef.plataformRef.codigo}\nuserDateTimeOnBoard: ${DateFormat('yyyy-MM-dd').format(group.userRef.dateTimeOnBoard)}\nmoduleId: ${group.moduleRef.codigo}\nworkerRefMap: ${workerRefMapData(group.workerRefMap)}'),
                  onTap: () {
                    widget.onArquivedFalse(group.id);
                  },
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    IconButton(
                      tooltip: 'Link para a pasta deste grupo',
                      icon: Icon(Icons.folder),
                      onPressed: () async {
                        if (group?.urlFolder != null) {
                          if (await canLaunch(group.urlFolder)) {
                            await launch(group.urlFolder);
                          }
                        }
                      },
                    ),
                    IconButton(
                      tooltip: 'Link para a foto do encontro deste grupo',
                      icon: Icon(Icons.people),
                      onPressed: () async {
                        if (group?.urlPhoto != null) {
                          if (await canLaunch(group.urlPhoto)) {
                            await launch(group.urlPhoto);
                          }
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
