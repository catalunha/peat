import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peat/models/plataform_model.dart';
import 'package:peat/states/app_state.dart';

// +++ Actions Sync

// +++ Actions Async
class GetListPlatatormAction extends ReduxAction<AppState> {
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
