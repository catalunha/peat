import 'package:meta/meta.dart';
import 'package:peat/models/plataform_model.dart';

@immutable
class PlataformState {
  // final PlataformFilter plataformFilter;
  final List<PlataformModel> plataformList;
  // final List<PlataformModel> plataformSelected;
  // final List<PlataformModel> plataformFiltered;
  final PlataformModel plataformCurrent;
  PlataformState({
    this.plataformList,
    this.plataformCurrent,
  });
  factory PlataformState.initialState() => PlataformState(
        plataformList: <PlataformModel>[],
        plataformCurrent: null,
      );
  PlataformState copyWith({
    List<PlataformModel> plataformList,
    PlataformModel plataformCurrent,
  }) =>
      PlataformState(
        plataformList: plataformList ?? this.plataformList,
        plataformCurrent: plataformCurrent ?? this.plataformCurrent,
      );
  @override
  int get hashCode => plataformList.hashCode ^ plataformCurrent.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlataformState &&
          runtimeType == other.runtimeType &&
          plataformList == other.plataformList &&
          plataformCurrent == other.plataformCurrent;
}
