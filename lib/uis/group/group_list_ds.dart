import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peat/models/group_model.dart';
import 'package:peat/models/module_model.dart';
import 'package:peat/models/plataform_model.dart';
import 'package:peat/models/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class GroupListDS extends StatelessWidget {
  final List<GroupModel> groupList;
  final List<ModuleModel> moduleList;
  final List<PlataformModel> plataformList;
  final UserModel userModel;
  final Function(String) onEditGroupCurrent;

  const GroupListDS({
    Key key,
    this.groupList,
    this.onEditGroupCurrent,
    this.moduleList,
    this.plataformList,
    this.userModel,
  }) : super(key: key);
  String moduleIdCodigo(String moduleId) {
    String _return;
    if (moduleId != null) {
      ModuleModel moduleModel =
          moduleList.firstWhere((element) => element.id == moduleId);
      _return = moduleModel.codigo;
    }
    return _return + ' || ' + moduleId.substring(0, 5);
  }

  String plataformIdCodigo(String plataformId) {
    String _return;
    if (plataformId != null) {
      PlataformModel plataformModel =
          plataformList.firstWhere((element) => element.id == plataformId);
      _return = plataformModel.codigo;
    }
    return _return + ' || ' + plataformId.substring(0, 5);
  }

  String userIdData(String userId) {
    String _return = 'Erro no userId';
    if (userId == userModel.id) {
      _return = '${userModel.displayName} || ${userModel.id.substring(0, 5)}';
    }
    return _return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${groupList.length} grupos'),
      ),
      body: ListView.builder(
        itemCount: groupList.length,
        itemBuilder: (context, index) {
          final group = groupList[index];
          return ListTile(
            selected: group.arquived,
            title: Text('${group.codigo}'),
            subtitle: Text(
                '\nnumber: ${group.number}\ndescription: ${group.description}\nstartCourse: ${DateFormat('yyyy-MM-dd HH:mm').format(group.startCourse)}\nendCourse: ${DateFormat('yyyy-MM-dd HH:mm').format(group.endCourse)}\nlocalCourse: ${group.localCourse}\nurlFolder: ${group.urlFolder}\nurlPhoto: ${group.urlPhoto}\nopened: ${group.opened}\nsuccess: ${group.success}\narquived: ${group.arquived}\nuserId: ${userIdData(group.userId)}\nplataformId: ${plataformIdCodigo(group.plataformId)}\nuserDateTimeOnBoard: ${DateFormat('yyyy-MM-dd').format(group.userDateTimeOnBoard)}\nmoduleId: ${moduleIdCodigo(group.moduleId)}\nworkerIdList: ${group.workerIdList != null ? group.workerIdList.length : null} '),
            leading: IconButton(
              icon: Icon(Icons.link),
              tooltip: group.urlPhoto,
              onPressed: () async {
                if (group?.urlPhoto != null) {
                  if (await canLaunch(group.urlPhoto)) {
                    await launch(group.urlPhoto);
                  }
                }
              },
            ),
            trailing: IconButton(
              icon: Icon(Icons.link),
              tooltip: group.urlFolder,
              onPressed: () async {
                if (group?.urlFolder != null) {
                  if (await canLaunch(group.urlFolder)) {
                    await launch(group.urlFolder);
                  }
                }
              },
            ),
            onTap: () {
              onEditGroupCurrent(group.id);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          onEditGroupCurrent(null);
        },
      ),
    );
  }
}
