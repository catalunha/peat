import 'package:flutter/material.dart';
import 'package:peat/models/module_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ModuleListDS extends StatelessWidget {
  final List<ModuleModel> moduleList;
  final Function(String) onEditModuleCurrent;

  const ModuleListDS({
    Key key,
    this.moduleList,
    this.onEditModuleCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${moduleList.length} Modulos'),
      ),
      body: ListView.builder(
        itemCount: moduleList.length,
        itemBuilder: (context, index) {
          final module = moduleList[index];
          return ListTile(
            selected: module.arquived,
            title: Text('${module.codigo}'),
            subtitle: Text('${module.description}\n${module.urlFolder}'),
            trailing: IconButton(
              icon: Icon(Icons.link),
              tooltip: module.urlFolder,
              onPressed: () async {
                if (module?.urlFolder != null) {
                  if (await canLaunch(module.urlFolder)) {
                    await launch(module.urlFolder);
                  }
                }
              },
            ),
            onTap: () {
              onEditModuleCurrent(module.id);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          onEditModuleCurrent(null);
        },
      ),
    );
  }
}
