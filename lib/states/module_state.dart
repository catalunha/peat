import 'package:meta/meta.dart';
import 'package:peat/models/module_model.dart';
import 'package:peat/states/types_states.dart';

@immutable
class ModuleState {
  final List<ModuleModel> moduleList;
  final ModuleOrder moduleOrder;
  final ModuleModel moduleCurrent;
  // final List<ModuleModel> moduleSelected;
  // final List<ModuleModel> moduleFiltered;
  ModuleState({
    this.moduleList,
    this.moduleOrder,
    this.moduleCurrent,
  });
  factory ModuleState.initialState() => ModuleState(
        moduleList: <ModuleModel>[],
        moduleOrder: ModuleOrder.codigo,
        moduleCurrent: null,
      );
  ModuleState copyWith({
    List<ModuleModel> moduleList,
    ModuleOrder moduleOrder,
    ModuleModel moduleCurrent,
  }) =>
      ModuleState(
        moduleList: moduleList ?? this.moduleList,
        moduleOrder: moduleOrder ?? this.moduleOrder,
        moduleCurrent: moduleCurrent ?? this.moduleCurrent,
      );
  @override
  int get hashCode =>
      moduleList.hashCode ^ moduleCurrent.hashCode ^ moduleOrder.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModuleState &&
          moduleOrder == other.moduleOrder &&
          moduleList == other.moduleList &&
          moduleCurrent == other.moduleCurrent &&
          runtimeType == other.runtimeType;
}
