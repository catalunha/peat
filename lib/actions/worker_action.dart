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

class BatchedDocsWorkerListOnBoardAsyncWorkerAction
    extends ReduxAction<AppState> {
  final List<String> sispatList;
  final bool inBoard;

  BatchedDocsWorkerListOnBoardAsyncWorkerAction({
    this.inBoard,
    this.sispatList,
  });
  @override
  Future<AppState> reduce() async {
    print('BatchedDocsWorkerListOnBoardAsyncWorkerAction...');
    Firestore firestore = Firestore.instance;

    var batch = firestore.batch();

    for (var sispat in sispatList) {
      var a = await firestore
          .collection(WorkerModel.collection)
          .where('sispat', isEqualTo: sispat)
          .limit(1)
          .getDocuments();
      if (a.documents?.length != null && a.documents.length > 0) {
        var b = a.documents[0];
        if (b.exists) {
          var c = firestore
              .collection(WorkerModel.collection)
              .document(b.documentID);
          batch.updateData(c, {
            'plataformIdOnBoard': inBoard
                ? state.loggedState.userModelLogged.plataformIdOnBoard
                : null
          });
        }
      }
    }

    await batch.commit();

    return null;
  }
}
