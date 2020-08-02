import 'package:flutter/material.dart';
import 'package:peat/models/module_model.dart';

class ModuleSelectDS extends StatelessWidget {
  final List<ModuleModel> moduleList;
  final Function(ModuleModel) onSetModuleTheGroup;

  const ModuleSelectDS({
    Key key,
    this.moduleList,
    this.onSetModuleTheGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 300.0,
        width: 400.0,
        child: ListView.builder(
          itemCount: moduleList.length,
          itemBuilder: (context, index) {
            final module = moduleList[index];
            return ListTile(
              title: Text('${module.codigo}'),
              subtitle: Text('${module.description}'),
              onTap: () {
                onSetModuleTheGroup(module);
              },
            );
          },
        ),
      ),
    );
  }
}
