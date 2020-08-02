import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peat/models/worker_model.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/states/types_states.dart';

// +++ Actions Sync
class SetWorkerCurrentSyncWorkerAction extends ReduxAction<AppState> {
  final String id;

  SetWorkerCurrentSyncWorkerAction(this.id);

  @override
  AppState reduce() {
    print('SetWorkerCurrentSyncWorkerAction...');
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

class SetWorkerOrderSyncUserAction extends ReduxAction<AppState> {
  final WorkerOrder workerOrder;

  SetWorkerOrderSyncUserAction(this.workerOrder);
  @override
  AppState reduce() {
    List<WorkerModel> _workerList = [];
    _workerList.addAll(state.workerState.workerList);
    if (workerOrder == WorkerOrder.sispat) {
      _workerList.sort((a, b) => a.sispat.compareTo(b.sispat));
    } else if (workerOrder == WorkerOrder.displayName) {
      _workerList.sort((a, b) => a.displayName.compareTo(b.displayName));
    } else if (workerOrder == WorkerOrder.company) {
      _workerList.sort((a, b) => a.company.compareTo(b.company));
    } else if (workerOrder == WorkerOrder.activity) {
      _workerList.sort((a, b) => a.activity.compareTo(b.activity));
    }
    return state.copyWith(
      workerState: state.workerState.copyWith(
        workerOrder: workerOrder,
        workerList: _workerList,
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

    final collRef = firestore
        .collection(WorkerModel.collection)
        .where('plataformIdOnBoard',
            isEqualTo: state.loggedState.userModelLogged.plataformRef.id)
        .where('arquived', isEqualTo: false);

    final docsSnap = await collRef.getDocuments();

    final listDocs = docsSnap.documents
        .map((docSnap) => WorkerModel(docSnap.documentID).fromMap(docSnap.data))
        .toList();
    print('GetDocsWorkerListAsyncWorkerAction...$listDocs');

    return state.copyWith(
      workerState: state.workerState.copyWith(
        workerList: listDocs,
      ),
    );
  }
}

class GetDocsWorkerListAllAsyncWorkerAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    print('GetDocsWorkerListAllAsyncWorkerAction...');
    Firestore firestore = Firestore.instance;

    final collRef = firestore.collection(WorkerModel.collection);
    final docsSnap = await collRef.getDocuments();

    final listDocs = docsSnap.documents
        .map((docSnap) => WorkerModel(docSnap.documentID).fromMap(docSnap.data))
        .toList();
    print('GetDocsWorkerListAllAsyncWorkerAction...$listDocs');

    return state.copyWith(
      workerState: state.workerState.copyWith(
        workerList: listDocs,
      ),
    );
  }
}

class CreateDocWorkerCurrentAsyncWorkerAction extends ReduxAction<AppState> {
  final String sispat;
  final String displayName;
  final String activity;
  final String company;

  CreateDocWorkerCurrentAsyncWorkerAction({
    this.sispat,
    this.displayName,
    this.activity,
    this.company,
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
    workerModel.arquived = false;
    var docRef = await firestore
        .collection(WorkerModel.collection)
        .where('sispat', isEqualTo: sispat)
        .getDocuments();
    bool doc = docRef.documents.length != 0;
    if (doc) throw const UserException("Esta trabalhador já foi cadastrado.");
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
  Object wrapError(error) => UserException("ATENÇÃO:", cause: error);
  @override
  void after() => dispatch(GetDocsWorkerListAsyncWorkerAction());
}

class UpdateDocWorkerCurrentAsyncWorkerAction extends ReduxAction<AppState> {
  final String sispat;
  final String displayName;
  final String activity;
  final String company;
  final bool arquived;

  UpdateDocWorkerCurrentAsyncWorkerAction({
    this.sispat,
    this.displayName,
    this.activity,
    this.company,
    this.arquived,
  });
  @override
  Future<AppState> reduce() async {
    print('UpdateDocWorkerCurrentAsyncWorkerAction...');
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
        .updateData(workerModel.toMap());
    return state.copyWith(
      workerState: state.workerState.copyWith(
        workerCurrent: workerModel,
      ),
    );
  }

  @override
  void after() => dispatch(GetDocsWorkerListAsyncWorkerAction());
}

class SetDocWorkerAsyncWorkerAction extends ReduxAction<AppState> {
  final String id;
  final Map<String, dynamic> data;

  SetDocWorkerAsyncWorkerAction({
    this.id,
    this.data,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocWorkerAsyncWorkerAction...');
    Firestore firestore = Firestore.instance;

    await firestore
        .collection(WorkerModel.collection)
        .document(id)
        .setData(data, merge: true);
    return null;
  }

  @override
  void after() => dispatch(GetDocsWorkerListAllAsyncWorkerAction());
}

class SetWorkerMsgSyncWorkerAction extends ReduxAction<AppState> {
  final String msg;

  SetWorkerMsgSyncWorkerAction(this.msg);
  @override
  AppState reduce() {
    String _msg = '';
    if (msg != null) {
      _msg = state.workerState.workerMsg + '\n' + msg;
    }
    return state.copyWith(
      workerState: state.workerState.copyWith(
        workerMsg: _msg,
      ),
    );
  }
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

    for (String sispat in sispatList) {
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
                ? state.loggedState.userModelLogged.plataformRef.id
                : null
          });
        }
      } else {
        dispatch(SetWorkerMsgSyncWorkerAction(sispat));
      }
    }

    await batch.commit();

    return null;
  }

  @override
  void before() => dispatch(WaitAction.add(this));
  @override
  void after() => dispatch(WaitAction.remove(this));
}

class BatchedDocsWorkerListInModuleAsyncWorkerAction
    extends ReduxAction<AppState> {
  final List<dynamic> workerIdList;
  final String moduleId;

  BatchedDocsWorkerListInModuleAsyncWorkerAction({
    this.workerIdList,
    this.moduleId,
  });
  @override
  Future<AppState> reduce() async {
    print('BatchedDocsWorkerListInModuleAsyncWorkerAction...');
    Firestore firestore = Firestore.instance;

    var batch = firestore.batch();

    for (var workerId in workerIdList) {
      var c = firestore
          .collection(WorkerModel.collection)
          .document(workerId.toString());
      batch.updateData(c, {
        'moduleIdList': FieldValue.arrayUnion([moduleId])
      });
    }

    await batch.commit();

    return null;
  }
}
