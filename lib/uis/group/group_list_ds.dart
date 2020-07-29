import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peat/models/group_model.dart';
import 'package:url_launcher/url_launcher.dart';

class GroupListDS extends StatelessWidget {
  final List<GroupModel> groupList;
  final Function(String) onEditGroupCurrent;

  const GroupListDS({
    Key key,
    this.groupList,
    this.onEditGroupCurrent,
  }) : super(key: key);

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
                '\nnumber: ${group.number}\ndescription: ${group.description}\nstartCourse: ${DateFormat('yyyy-MM-dd HH:mm').format(group.startCourse)}\nendCourse: ${DateFormat('yyyy-MM-dd HH:mm').format(group.endCourse)}\nlocalCourse: ${group.localCourse}\nurlFolder: ${group.urlFolder}\nurlPhoto: ${group.urlPhoto}\nopened: ${group.opened}\nsuccess: ${group.success}\narquived: ${group.arquived}\nuserId: ${group.userId.substring(0, 5)}\nplataformId: ${group.plataformId.substring(0, 5)}\nuserDateTimeOnBoard: ${DateFormat('yyyy-MM-dd').format(group.userDateTimeOnBoard)}'),
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
