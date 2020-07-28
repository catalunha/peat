import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peat/models/worker_model.dart';
import 'package:peat/states/app_state.dart';

// +++ Actions Sync
class SetWorkerCurrentSyncWorkerAction extends ReduxAction<AppState> {
  final String id;

  SetWorkerCurrentSyncWorkerAction(this.id);

  @override
  AppState reduce() {
    WorkerModel workerModel = id == null
        ? WorkerModel(null)
        : state.workerState.workerList
            .firstWhere((element) => element.id == id);
    return state.copyWith(
      workerState: state.workerState.copyWith(
        workerCurrent: workerModel,
      ),
    );
  }
}

// +++ Actions Async
class GetDocsWorkerListAsyncWorkerAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    print('GetDocsWorkerListAsyncWorkerAction...');
    Firestore firestore = Firestore.instance;

    final collRef = firestore.collection(WorkerModel.collection);
    final docsSnap = await collRef.getDocuments();

    final listDocs = docsSnap.documents
        .map((docSnap) => WorkerModel(docSnap.documentID).fromMap(docSnap.data))
        .toList();
    return state.copyWith(
      workerState: state.workerState.copyWith(
        workerList: listDocs,
      ),
    );
  }
}

class SetDocWorkerCurrentAsyncWorkerAction extends ReduxAction<AppState> {
  final String sispat;
  final String displayName;
  final String activity;
  final String company;
  final bool arquived;

  SetDocWorkerCurrentAsyncWorkerAction({
    this.sispat,
    this.displayName,
    this.activity,
    this.company,
    this.arquived,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocWorkerCurrentAsyncWorkerAction...');
    Firestore firestore = Firestore.instance;
    WorkerModel workerModel = state.workerState.workerCurrent;
    workerModel.sispat = sispat;
    workerModel.displayName = displayName;
    workerModel.activity = activity;
    workerModel.company = company;
    workerModel.arquived = arquived;

    await firestore
        .collection(WorkerModel.collection)
        .document(workerModel.id)
        .setData(workerModel.toMap(), merge: true);
    return state.copyWith(
      workerState: state.workerState.copyWith(
        workerCurrent: workerModel,
      ),
    );
  }

  @override
  void after() => dispatch(GetDocsWorkerListAsyncWorkerAction());
}
