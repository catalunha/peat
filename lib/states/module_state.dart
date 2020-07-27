import 'package:meta/meta.dart';
import 'package:peat/models/module_model.dart';

@immutable
class ModuleState {
  // final PlataformFilter moduleFilter;
  final List<ModuleModel> moduleList;
  // final List<ModuleModel> moduleSelected;
  // final List<ModuleModel> moduleFiltered;
  final ModuleModel moduleCurrent;
  ModuleState({
    this.moduleList,
    this.moduleCurrent,
  });
  factory ModuleState.initialState() => ModuleState(
        moduleList: <ModuleModel>[],
        moduleCurrent: null,
      );
  ModuleState copyWith({
    List<ModuleModel> moduleList,
    ModuleModel moduleCurrent,
  }) =>
      ModuleState(
        moduleList: moduleList ?? this.moduleList,
        moduleCurrent: moduleCurrent ?? this.moduleCurrent,
      );
  @override
  int get hashCode => moduleList.hashCode ^ moduleCurrent.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModuleState &&
          runtimeType == other.runtimeType &&
          moduleList == other.moduleList &&
          moduleCurrent == other.moduleCurrent;
}
