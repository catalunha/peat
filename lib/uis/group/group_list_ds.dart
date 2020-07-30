import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peat/models/group_model.dart';
import 'package:peat/models/module_model.dart';
import 'package:peat/models/plataform_model.dart';
import 'package:peat/models/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class GroupListDS extends StatefulWidget {
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

  @override
  _GroupListDSState createState() => _GroupListDSState();
}

class _GroupListDSState extends State<GroupListDS> {
  String moduleIdCodigo(String moduleId) {
    String _return;
    if (moduleId != null) {
      ModuleModel moduleModel =
          widget.moduleList.firstWhere((element) => element.id == moduleId);
      _return = moduleModel.codigo;
    }
    return _return + ' || ' + moduleId.substring(0, 5);
  }

  String plataformIdCodigo(String plataformId) {
    String _return;
    if (plataformId != null) {
      PlataformModel plataformModel = widget.plataformList
          .firstWhere((element) => element.id == plataformId);
      _return = plataformModel.codigo;
    }
    return _return + ' || ' + plataformId.substring(0, 5);
  }

  String userIdData(String userId) {
    String _return = 'Erro no userId';
    if (userId == widget.userModel.id) {
      _return =
          '${widget.userModel.displayName} || ${widget.userModel.id.substring(0, 5)}';
    }
    return _return;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lista com ${widget.groupList.length} grupos'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Abertos',
              ),
              Tab(
                text: 'Fechados',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: widget.groupList.length,
              itemBuilder: (context, index) {
                final group = widget.groupList[index];
                if (group.opened) {
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
                      widget.onEditGroupCurrent(group.id);
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
            ListView.builder(
              itemCount: widget.groupList.length,
              itemBuilder: (context, index) {
                final group = widget.groupList[index];
                if (!group.opened) {
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
                      widget.onEditGroupCurrent(group.id);
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            widget.onEditGroupCurrent(null);
          },
        ),
      ),
    );
  }
}
