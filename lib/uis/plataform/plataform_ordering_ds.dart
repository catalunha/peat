import 'package:flutter/material.dart';
import 'package:peat/states/types_states.dart';

class PlataformOrderingDS extends StatelessWidget
    with _PlataformOrderingDSComponents {
  final PlataformOrder plataformOrder;
  final Function(PlataformOrder) onSelectOrder;

  PlataformOrderingDS({Key key, this.plataformOrder, this.onSelectOrder})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PlataformOrder>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      icon: popupIcon(plataformOrder),
      tooltip: 'Ordenar plataforma por',
      onSelected: (value) => onSelectOrder(value),
      itemBuilder: (context) => <PopupMenuItem<PlataformOrder>>[
        PopupMenuItem<PlataformOrder>(
          value: PlataformOrder.codigo,
          child: Row(
            children: [
              codigoIcon,
              SizedBox(width: 5),
              Text(PlataformOrder.codigo.name),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlataformOrderingDSComponents {
  final codigoIcon = Icon(Icons.sort_by_alpha);
  Icon popupIcon(PlataformOrder plataformOrder) {
    var icon = codigoIcon;
    return icon;
  }
}
