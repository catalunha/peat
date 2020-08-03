import 'package:flutter/material.dart';
import 'package:peat/states/types_states.dart';

class ModuleOrderingDS extends StatelessWidget
    with _ModuleOrderingDSComponents {
  final ModuleOrder moduleOrder;
  final Function(ModuleOrder) onSelectOrder;

  ModuleOrderingDS({Key key, this.moduleOrder, this.onSelectOrder})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ModuleOrder>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      icon: popupIcon(moduleOrder),
      tooltip: 'Ordenar modulo por',
      onSelected: (value) => onSelectOrder(value),
      itemBuilder: (context) => <PopupMenuItem<ModuleOrder>>[
        PopupMenuItem<ModuleOrder>(
          value: ModuleOrder.codigo,
          child: Row(
            children: [
              codigoIcon,
              SizedBox(width: 5),
              Text(ModuleOrder.codigo.name),
            ],
          ),
        ),
      ],
    );
  }
}

class _ModuleOrderingDSComponents {
  final codigoIcon = Icon(Icons.sort_by_alpha);
  Icon popupIcon(ModuleOrder moduleOrder) {
    var icon = codigoIcon;
    return icon;
  }
}
