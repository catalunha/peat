import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peat/actions/worker_action.dart';
import 'package:peat/models/group_model.dart';
import 'package:peat/models/module_model.dart';
import 'package:peat/models/plataform_model.dart';
import 'package:peat/models/user_model.dart';
import 'package:peat/models/worker_model.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/states/types_states.dart';

// +++ Actions Sync
class SetGroupCurrentSyncGroupAction extends ReduxAction<AppState> {
  final String id;

  SetGroupCurrentSyncGroupAction(this.id);

  @override
  AppState reduce() {
    print('SetGroupCurrentSyncGroupAction...$id');
    GroupModel groupModel = id == null
        ? GroupModel(null)
        : state.groupState.groupList.firstWhere((element) => element.id == id);
    return state.copyWith(
      groupState: state.groupState.copyWith(
        groupCurrent: groupModel,
      ),
    );
  }
}

class SetGroupOrderSyncUserAction extends ReduxAction<AppState> {
  final GroupOrder groupOrder;

  SetGroupOrderSyncUserAction(this.groupOrder);
  @override
  AppState reduce() {
    List<GroupModel> _groupList = [];
    _groupList.addAll(state.groupState.groupList);
    if (groupOrder == GroupOrder.codigo) {
      _groupList.sort((a, b) => a.codigo.compareTo(b.codigo));
    } else if (groupOrder == GroupOrder.number) {
      _groupList.sort((a, b) => a.number.compareTo(b.number));
    } else if (groupOrder == GroupOrder.startCourse) {
      _groupList.sort((a, b) => a.startCourse.compareTo(b.startCourse));
    } else if (groupOrder == GroupOrder.localCourse) {
      _groupList.sort((a, b) => a.localCourse.compareTo(b.localCourse));
    }
    return state.copyWith(
      groupState: state.groupState.copyWith(
        groupOrder: groupOrder,
        groupList: _groupList,
      ),
    );
  }
}

// +++ Actions Async
class GetDocsGroupListAsyncGroupAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    print('GetDocsGroupListAsyncGroupAction...');
    Firestore firestore = Firestore.instance;

    final collRef = firestore
        .collection(GroupModel.collection)
        .where('userRef.id', isEqualTo: state.loggedState.userModelLogged.id)
        .where('userRef.plataformRef.id',
            isEqualTo: state.loggedState.userModelLogged.plataformRef.id)
        .where('arquived', isEqualTo: false);
    final docsSnap = await collRef.getDocuments();

    final listDocs = docsSnap.documents
        .map((docSnap) => GroupModel(docSnap.documentID).fromMap(docSnap.data))
        .toList();
    return state.copyWith(
      groupState: state.groupState.copyWith(
        groupList: listDocs,
      ),
    );
  }
}

class GetDocsGroupListAllAsyncGroupAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    print('GetDocsGroupListAllAsyncGroupAction...');
    Firestore firestore = Firestore.instance;

    final collRef = firestore
        .collection(GroupModel.collection)
        .where('userRef.id', isEqualTo: state.loggedState.userModelLogged.id)
        .where('userRef.plataformRef.id',
            isEqualTo: state.loggedState.userModelLogged.plataformRef.id)
        .where('arquived', isEqualTo: true);
    final docsSnap = await collRef.getDocuments();

    final listDocs = docsSnap.documents
        .map((docSnap) => GroupModel(docSnap.documentID).fromMap(docSnap.data))
        .toList();
    return state.copyWith(
      groupState: state.groupState.copyWith(
        groupList: listDocs,
      ),
    );
  }
}

class CreateDocGroupCurrentAsyncGroupAction extends ReduxAction<AppState> {
  final String codigo; //p65.200121.01
  final dynamic userDateTimeOnBoard;
  final String number;
  final dynamic startCourse;
  final dynamic endCourse;
  final String localCourse;
  final String urlFolder;
  final String urlPhoto;
  final String description;
  CreateDocGroupCurrentAsyncGroupAction({
    this.codigo,
    this.userDateTimeOnBoard,
    this.number,
    this.startCourse,
    this.endCourse,
    this.localCourse,
    this.urlFolder,
    this.urlPhoto,
    this.description,
  });
  @override
  Future<AppState> reduce() async {
    print('CreateDocGroupCurrentAsyncGroupAction...');
    Firestore firestore = Firestore.instance;
    GroupModel groupModel = state.groupState.groupCurrent;
    groupModel.codigo = codigo;

    groupModel.userRef = UserModel(state.loggedState.userModelLogged.id)
        .fromMap(state.loggedState.userModelLogged.toMapRef());

    groupModel.number = number;
    groupModel.startCourse = startCourse;
    groupModel.endCourse = endCourse;
    groupModel.localCourse = localCourse;
    groupModel.urlFolder = urlFolder;
    groupModel.urlPhoto = urlPhoto;
    groupModel.description = description;
    groupModel.opened = true;
    groupModel.success = false;
    groupModel.created = FieldValue.serverTimestamp();
    groupModel.arquived = false;
    var docRef = await firestore
        .collection(GroupModel.collection)
        .where('codigo', isEqualTo: codigo)
        .getDocuments();
    bool doc = docRef.documents.length != 0;
    if (doc) throw const UserException("Esta grupo já foi cadastrado.");
    await firestore
        .collection(GroupModel.collection)
        .document(groupModel.id)
        .setData(groupModel.toMap(), merge: true);
    return state.copyWith(
      groupState: state.groupState.copyWith(
        groupCurrent: groupModel,
      ),
    );
  }

  @override
  Object wrapError(error) => UserException("ATENÇÃO:", cause: error);
  @override
  void after() => dispatch(GetDocsGroupListAsyncGroupAction());
}

class UpdateDocGroupCurrentAsyncGroupAction extends ReduxAction<AppState> {
  final String codigo; //p65.200121.01
  final dynamic userDateTimeOnBoard;
  final String number;
  final dynamic startCourse;
  final dynamic endCourse;
  final String localCourse;
  final String urlFolder;
  final String urlPhoto;
  final String description;
  final bool opened;
  final bool success;
  final bool arquived;
  UpdateDocGroupCurrentAsyncGroupAction({
    this.codigo,
    this.userDateTimeOnBoard,
    this.number,
    this.startCourse,
    this.endCourse,
    this.localCourse,
    this.urlFolder,
    this.urlPhoto,
    this.description,
    this.opened,
    this.success,
    this.arquived,
  });
  @override
  Future<AppState> reduce() async {
    print('UpdateDocGroupCurrentAsyncGroupAction...');
    Firestore firestore = Firestore.instance;
    GroupModel groupModel = GroupModel(state.groupState.groupCurrent.id)
        .fromMap(state.groupState.groupCurrent.toMap());
    groupModel.codigo = codigo;

    groupModel.number = number;
    groupModel.startCourse = startCourse;
    groupModel.endCourse = endCourse;
    groupModel.localCourse = localCourse;
    groupModel.urlFolder = urlFolder;
    groupModel.urlPhoto = urlPhoto;
    groupModel.description = description;
    groupModel.opened = opened;
    groupModel.success = success;
    groupModel.arquived = arquived;
    if (arquived && success) {
      dispatch(BatchedDocsWorkerListInModuleAsyncWorkerAction(
        workerRefMap: state.groupState.groupCurrent.workerRefMap,
        moduleRef: state.groupState.groupCurrent.moduleRef,
      ));
    }
    await firestore
        .collection(GroupModel.collection)
        .document(groupModel.id)
        .updateData(groupModel.toMap());
    return state.copyWith(
      groupState: state.groupState.copyWith(
        groupCurrent: groupModel,
      ),
    );
  }

  @override
  void after() => dispatch(GetDocsGroupListAsyncGroupAction());
}

class SetDocGroupAsyncGroupAction extends ReduxAction<AppState> {
  final String id;
  final Map<String, dynamic> data;

  SetDocGroupAsyncGroupAction({
    this.id,
    this.data,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocGroupAsyncGroupAction...');
    Firestore firestore = Firestore.instance;

    await firestore
        .collection(GroupModel.collection)
        .document(id)
        .setData(data, merge: true);
    return null;
  }

  @override
  void after() => dispatch(GetDocsGroupListAllAsyncGroupAction());
}

class SetModuleTheGroupSyncGroupAction extends ReduxAction<AppState> {
  final ModuleModel moduleModel;
  SetModuleTheGroupSyncGroupAction({this.moduleModel});
  @override
  AppState reduce() {
    GroupModel groupModel = state.groupState.groupCurrent;
    groupModel.moduleRef = moduleModel;
    return state.copyWith(
      groupState: state.groupState.copyWith(
        groupCurrent: groupModel,
      ),
    );
  }
}

class SetWorkerTheGroupSyncGroupAction extends ReduxAction<AppState> {
  final WorkerModel workerRef;
  final bool addOrRemove;
  SetWorkerTheGroupSyncGroupAction({
    this.workerRef,
    this.addOrRemove,
  });
  @override
  AppState reduce() {
    GroupModel groupModel = GroupModel(state.groupState.groupCurrent.id)
        .fromMap(state.groupState.groupCurrent.toMap());

    if (groupModel.workerRefMap == null)
      groupModel.workerRefMap = Map<String, WorkerModel>();
    if (addOrRemove) {
      if (!groupModel.workerRefMap.containsKey(workerRef.id)) {
        groupModel.workerRefMap.addAll({workerRef.id: workerRef});
        print('groupModel.workerRefMap1: ${groupModel.workerRefMap}');
        return state.copyWith(
          groupState: state.groupState.copyWith(
            groupCurrent: groupModel,
          ),
        );
      } else {
        print('groupModel.workerRefMap2: ${groupModel.workerRefMap}');
        return null;
      }
    } else {
      groupModel.workerRefMap.remove(workerRef.id);
      print('groupModel.workerRefMap3: ${groupModel.workerRefMap}');
      return state.copyWith(
        groupState: state.groupState.copyWith(
          groupCurrent: groupModel,
        ),
      );
    }
  }
}
