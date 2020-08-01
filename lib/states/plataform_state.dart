import 'package:meta/meta.dart';
import 'package:peat/models/plataform_model.dart';
import 'package:peat/states/types_states.dart';

@immutable
class PlataformState {
  final List<PlataformModel> plataformList;
  final PlataformOrder plataformOrder;
  final PlataformModel plataformCurrent;
  // final List<PlataformModel> plataformSelected;
  // final List<PlataformModel> plataformFiltered;
  PlataformState({
    this.plataformList,
    this.plataformOrder,
    this.plataformCurrent,
  });
  factory PlataformState.initialState() => PlataformState(
        plataformList: <PlataformModel>[],
        plataformCurrent: null,
        plataformOrder: PlataformOrder.codigo,
      );
  PlataformState copyWith({
    List<PlataformModel> plataformList,
    PlataformModel plataformCurrent,
    PlataformOrder plataformOrder,
  }) =>
      PlataformState(
        plataformList: plataformList ?? this.plataformList,
        plataformCurrent: plataformCurrent ?? this.plataformCurrent,
        plataformOrder: plataformOrder ?? this.plataformOrder,
      );
  @override
  int get hashCode =>
      plataformList.hashCode ^
      plataformCurrent.hashCode ^
      plataformOrder.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlataformState &&
          plataformOrder == other.plataformOrder &&
          plataformList == other.plataformList &&
          plataformCurrent == other.plataformCurrent &&
          runtimeType == other.runtimeType;
}
