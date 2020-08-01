import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peat/conectors/group/group_ordering.dart';
import 'package:peat/models/group_model.dart';
import 'package:peat/models/module_model.dart';
import 'package:peat/models/plataform_model.dart';
import 'package:peat/models/user_model.dart';
import 'package:peat/models/worker_model.dart';
import 'package:url_launcher/url_launcher.dart';

class GroupListDS extends StatefulWidget {
  final List<GroupModel> groupList;
  final List<ModuleModel> moduleList;
  final List<PlataformModel> plataformList;
  final UserModel userModel;
  final List<WorkerModel> workerList;

  final Function(String) onEditGroupCurrent;

  const GroupListDS({
    Key key,
    this.groupList,
    this.onEditGroupCurrent,
    this.moduleList,
    this.plataformList,
    this.userModel,
    this.workerList,
  }) : super(key: key);

  @override
  _GroupListDSState createState() => _GroupListDSState();
}

class _GroupListDSState extends State<GroupListDS> {
  Future<void> _launched;

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

  String workerIdListData(List<dynamic> workerIdList) {
    String _return = '';
    if (widget?.workerList != null && widget.workerList.isNotEmpty) {
      if (workerIdList != null && workerIdList.isNotEmpty) {
        workerIdList.forEach((workerId) {
          WorkerModel workerModel =
              widget.workerList.firstWhere((worker) => worker.id == workerId);
          _return = _return +
              '\n${workerModel.displayName} || ${workerModel.id.substring(0, 5)}';
        });
      }
    } else {
      _return = 'Trabalhadores não estão OnBoard:';
      if (workerIdList != null && workerIdList.isNotEmpty) {
        workerIdList.forEach((workerId) {
          _return = _return + '\n${workerId.toString()}';
        });
      }
    }
    return _return;
  }

  String userIdData(String userId) {
    String _return = 'Erro no userId';
    if (userId == widget.userModel.id) {
      _return =
          '${widget.userModel.displayName} || ${widget.userModel.id.substring(0, 5)}';
    }
    return _return;
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lista com ${widget.groupList.length} grupos'),
          actions: [GroupOrdering()],
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Agendados',
              ),
              Tab(
                text: 'Encerrados',
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
                        '\id: ${group.id.substring(0, 5)}\nnumber: ${group.number}\ndescription: ${group.description}\nstartCourse: ${DateFormat('yyyy-MM-dd HH:mm').format(group.startCourse)}\nendCourse: ${DateFormat('yyyy-MM-dd HH:mm').format(group.endCourse)}\nlocalCourse: ${group.localCourse}\nurlFolder: ${group.urlFolder}\nurlPhoto: ${group.urlPhoto}\nopened: ${group.opened}\nsuccess: ${group.success}\narquived: ${group.arquived}\nuserId: ${userIdData(group.userId)}\nplataformId: ${group.plataformModel.codigo}\nuserDateTimeOnBoard: ${DateFormat('yyyy-MM-dd').format(group.userDateTimeOnBoard)}\nmoduleId: ${moduleIdCodigo(group.moduleId)}\nworkerIdList: ${workerIdListData(group.workerIdList)} '),
                    // trailing: PopupMenuButton<int>(
                    //   icon: Icon(Icons.link),
                    //   itemBuilder: (context) => [
                    //     PopupMenuItem(
                    //       value: 1,
                    //       child: Text("urlPhoto"),
                    //     ),
                    //     PopupMenuItem(
                    //       value: 2,
                    //       child: Text("urlFolder"),
                    //     ),
                    //   ],
                    //   onSelected: (value) {
                    //     if (value == 1) {
                    //       setState(() {
                    //         _launched = _launchInBrowser(group.urlPhoto);
                    //       });
                    //     } else {
                    //       setState(() {
                    //         _launched = _launchInBrowser(group.urlFolder);
                    //       });
                    //     }
                    //   },
                    // ),

                    // trailing: IconButton(
                    //   icon: Icon(Icons.link),
                    //   tooltip: group.urlPhoto,
                    //   onPressed: () => setState(() {
                    //     _launched = _launchInBrowser(group.urlPhoto);
                    //   }),
                    onTap: () {
                      print('ops');
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
                        '\nnumber: ${group.number}\ndescription: ${group.description}\nstartCourse: ${DateFormat('yyyy-MM-dd HH:mm').format(group.startCourse)}\nendCourse: ${DateFormat('yyyy-MM-dd HH:mm').format(group.endCourse)}\nlocalCourse: ${group.localCourse}\nurlFolder: ${group.urlFolder}\nurlPhoto: ${group.urlPhoto}\nopened: ${group.opened}\nsuccess: ${group.success}\narquived: ${group.arquived}\nuserId: ${userIdData(group.userId)}\nplataformId: ${group.plataformModel.codigo}}\nuserDateTimeOnBoard: ${DateFormat('yyyy-MM-dd').format(group.userDateTimeOnBoard)}\nmoduleId: ${moduleIdCodigo(group.moduleId)}\nworkerIdList: ${workerIdListData(group.workerIdList)}  '),
                    onTap: () {
                      widget.onEditGroupCurrent(group.id);
                    },
                    trailing: IconButton(
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
                    // leading: PopupMenuButton<int>(
                    //   itemBuilder: (context) => [
                    //     PopupMenuItem(
                    //       value: 1,
                    //       child: Text("urlPhoto"),
                    //     ),
                    //     PopupMenuItem(
                    //       value: 2,
                    //       child: Text("urlFolder"),
                    //     ),
                    //   ],
                    //   onSelected: (value) {
                    //     if (value == 1) {
                    //       Future<void> a() async {
                    //         if (group?.urlPhoto != null) {
                    //           if (await canLaunch(group.urlPhoto)) {
                    //             await launch(group.urlPhoto);
                    //           }
                    //         }
                    //       }

                    //       a();
                    //     } else {
                    //       Future<void> b() async {
                    //         if (group?.urlFolder != null) {
                    //           if (await canLaunch(group.urlFolder)) {
                    //             await launch(group.urlFolder);
                    //           }
                    //         }
                    //       }

                    //       b();
                    //     }
                    //   },
                    // ),
                    // trailing: IconButton(
                    //   icon: Icon(Icons.link),
                    //   tooltip: group.urlFolder,
                    //   onPressed: () async {
                    //     if (group?.urlFolder != null) {
                    //       if (await canLaunch(group.urlFolder)) {
                    //         await launch(group.urlFolder);
                    //       }
                    //     }
                    //   },
                    // ),
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
