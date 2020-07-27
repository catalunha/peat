import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peat/models/plataform_model.dart';
import 'package:peat/states/app_state.dart';

// +++ Actions Sync
class SetPlataformCurrentSyncPlataformAction extends ReduxAction<AppState> {
  final String id;

  SetPlataformCurrentSyncPlataformAction(this.id);

  @override
  AppState reduce() {
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

// +++ Actions Async
class GetDocsPlatatormListAsyncPlataformAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    print('GetListPlatatormAction...');
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

class SetDocPlataformCurrentAsyncPlataformAction extends ReduxAction<AppState> {
  final String codigo;
  final String description;
  final bool arquived;

  SetDocPlataformCurrentAsyncPlataformAction({
    this.codigo,
    this.description,
    this.arquived,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocPlataformCurrentAsyncPlataformAction...');
    Firestore firestore = Firestore.instance;
    PlataformModel plataformModel = state.plataformState.plataformCurrent;
    plataformModel.codigo = codigo;
    plataformModel.description = description;
    plataformModel.arquived = arquived;
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
  void after() => dispatch(GetDocsPlatatormListAsyncPlataformAction());
}
