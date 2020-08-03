import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peat/conectors/group/group_ordering.dart';
import 'package:peat/models/group_model.dart';
import 'package:peat/models/worker_model.dart';
import 'package:url_launcher/url_launcher.dart';

class GroupListDS extends StatefulWidget {
  final List<GroupModel> groupList;
  final List<WorkerModel> workerList;

  final Function(String) onEditGroupCurrent;

  const GroupListDS({
    Key key,
    this.groupList,
    this.onEditGroupCurrent,
    this.workerList,
  }) : super(key: key);

  @override
  _GroupListDSState createState() => _GroupListDSState();
}

class _GroupListDSState extends State<GroupListDS> {
  Future<void> _launched;

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

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    }
    //  else {
    //   throw 'Could not launch $url';
    // }
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
                print('group.id: ${group.id}');
                if (group.opened) {
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          selected: !group.success,
                          title: Text('${group.codigo}'),
                          subtitle: Text(
                              'number: ${group.number}\ndescription: ${group.description}\nstartCourse: ${DateFormat('yyyy-MM-dd HH:mm').format(group.startCourse)}\nendCourse: ${DateFormat('yyyy-MM-dd HH:mm').format(group.endCourse)}\nlocalCourse: ${group.localCourse}\nurlFolder: ${group.urlFolder}\nurlPhoto: ${group.urlPhoto}\nopened: ${group.opened}\nsuccess: ${group.success}\narquived: ${group.arquived}\nuserId: ${group.userRef.id}\nplataformId: ${group.userRef.plataformRef.codigo}\nuserDateTimeOnBoard: ${DateFormat('yyyy-MM-dd').format(group.userRef.dateTimeOnBoard)}\nmoduleId: ${group.moduleRef.codigo}\nworkerRefMap: ${workerRefMapData(group.workerRefMap)}'), //\ngroupModel: $group
                          onTap: () {
                            print('ops');
                            widget.onEditGroupCurrent(group.id);
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
                              tooltip:
                                  'Link para a foto do encontro deste grupo',
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
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          selected: group.arquived,
                          title: Text('${group.codigo}'),
                          subtitle: Text(
                              '\nnumber: ${group.number}\ndescription: ${group.description}\nstartCourse: ${DateFormat('yyyy-MM-dd HH:mm').format(group.startCourse)}\nendCourse: ${DateFormat('yyyy-MM-dd HH:mm').format(group.endCourse)}\nlocalCourse: ${group.localCourse}\nurlFolder: ${group.urlFolder}\nurlPhoto: ${group.urlPhoto}\nopened: ${group.opened}\nsuccess: ${group.success}\narquived: ${group.arquived}\nuserId: ${group.userRef.id}\nplataformId: ${group.userRef.plataformRef.codigo}}\nuserDateTimeOnBoard: ${DateFormat('yyyy-MM-dd').format(group.userRef.dateTimeOnBoard)}\nmoduleId: ${group.moduleRef.codigo}\nworkerRefMap: ${workerRefMapData(group.workerRefMap)}  '),
                          onTap: () {
                            widget.onEditGroupCurrent(group.id);
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
                              tooltip:
                                  'Link para a foto do encontro deste grupo',
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
// trailing: PopupMenuButton<int>(
//   shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(10)),
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
