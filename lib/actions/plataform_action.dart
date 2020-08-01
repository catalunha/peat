import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peat/models/plataform_model.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/states/types_states.dart';

// +++ Actions Sync
class SetPlataformCurrentSyncPlataformAction extends ReduxAction<AppState> {
  final String id;

  SetPlataformCurrentSyncPlataformAction(this.id);

  @override
  AppState reduce() {
    print('SetPlataformCurrentSyncPlataformAction...');
    PlataformModel plataformModel = id == null
        ? PlataformModel(null)
        : state.plataformState.plataformList
            .firstWhere((element) => element.id == id);
    return state.copyWith(
      plataformState: state.plataformState.copyWith(
        plataformCurrent: plataformModel,
      ),
    );
  }
}

class SetPlataformOrderSyncUserAction extends ReduxAction<AppState> {
  final PlataformOrder plataformOrder;

  SetPlataformOrderSyncUserAction(this.plataformOrder);
  @override
  AppState reduce() {
    List<PlataformModel> _plataformList = [];
    _plataformList.addAll(state.plataformState.plataformList);
    if (plataformOrder == PlataformOrder.codigo) {
      _plataformList.sort((a, b) => a.codigo.compareTo(b.codigo));
    }
    return state.copyWith(
      plataformState: state.plataformState.copyWith(
        plataformOrder: plataformOrder,
        plataformList: _plataformList,
      ),
    );
  }
}

// +++ Actions Async
class GetDocsPlataformListAsyncPlataformAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    print('GetDocsPlataformListAsyncPlataformAction...');
    Firestore firestore = Firestore.instance;

    final collRef = firestore.collection(PlataformModel.collection);
    final docsSnap = await collRef.getDocuments();

    final listDocs = docsSnap.documents
        .map((docSnap) =>
            PlataformModel(docSnap.documentID).fromMap(docSnap.data))
        .toList();
    return state.copyWith(
      plataformState: state.plataformState.copyWith(
        plataformList: listDocs,
      ),
    );
  }
}

class CreateDocPlataformCurrentAsyncPlataformAction
    extends ReduxAction<AppState> {
  final String codigo;
  final String description;

  CreateDocPlataformCurrentAsyncPlataformAction({
    this.codigo,
    this.description,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocPlataformCurrentAsyncPlataformAction...');
    Firestore firestore = Firestore.instance;
    PlataformModel plataformModel =
        state.plataformState.plataformCurrent.copy();
    plataformModel.codigo = codigo;
    plataformModel.description = description;
    plataformModel.arquived = false;
    var docRef = await firestore
        .collection(PlataformModel.collection)
        .where('codigo', isEqualTo: codigo)
        .getDocuments();
    bool doc = docRef.documents.length != 0;
    if (doc) throw const UserException("Esta plataforma já foi cadastrada.");

    await firestore
        .collection(PlataformModel.collection)
        .document(plataformModel.id)
        .setData(plataformModel.toMap(), merge: true);
    return state.copyWith(
      plataformState: state.plataformState.copyWith(
        plataformCurrent: plataformModel,
      ),
    );
  }

  @override
  Object wrapError(error) => UserException("ATENÇÃO:", cause: error);
  @override
  void after() => dispatch(GetDocsPlataformListAsyncPlataformAction());
}

class UpdateDocPlataformCurrentAsyncPlataformAction
    extends ReduxAction<AppState> {
  final String codigo;
  final String description;
  final bool arquived;

  UpdateDocPlataformCurrentAsyncPlataformAction({
    this.codigo,
    this.description,
    this.arquived,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocPlataformCurrentAsyncPlataformAction...');
    Firestore firestore = Firestore.instance;
    PlataformModel plataformModel =
        state.plataformState.plataformCurrent.copy();
    plataformModel.codigo = codigo;
    plataformModel.description = description;
    plataformModel.arquived = arquived;
    await firestore
        .collection(PlataformModel.collection)
        .document(plataformModel.id)
        .updateData(plataformModel.toMap());
    return state.copyWith(
      plataformState: state.plataformState.copyWith(
        plataformCurrent: plataformModel,
      ),
    );
  }

  @override
  void after() => dispatch(GetDocsPlataformListAsyncPlataformAction());
}
