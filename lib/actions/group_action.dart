import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peat/actions/worker_action.dart';
import 'package:peat/models/group_model.dart';
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
    // else if (groupOrder == GroupOrder.moduleId) {
    //   _groupList.sort((a, b) => a.moduleId.compareTo(b.moduleId));
    // }
    print('--------------------------');
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
        .where('userId', isEqualTo: state.loggedState.userModelLogged.id)
        .where('plataformId',
            isEqualTo: state.loggedState.userModelLogged.plataformIdOnBoard)
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

class CreateDocGroupCurrentAsyncGroupAction extends ReduxAction<AppState> {
  final String codigo; //p65.200121.01
  final String plataformId;
  final dynamic userDateTimeOnBoard;
  final String number;
  final String userId;
  final dynamic startCourse;
  final dynamic endCourse;
  final String localCourse;
  final String urlFolder;
  final String urlPhoto;
  final String description;
  CreateDocGroupCurrentAsyncGroupAction({
    this.codigo,
    this.plataformId,
    this.userDateTimeOnBoard,
    this.number,
    this.userId,
    this.startCourse,
    this.endCourse,
    this.localCourse,
    this.urlFolder,
    this.urlPhoto,
    this.description,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocGroupCurrentAsyncGroupAction...');
    Firestore firestore = Firestore.instance;
    GroupModel groupModel = state.groupState.groupCurrent;
    groupModel.codigo = codigo;
    groupModel.plataformId = plataformId;
    groupModel.userDateTimeOnBoard = userDateTimeOnBoard;
    groupModel.number = number;
    groupModel.userId = userId;
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
  final String plataformId;
  final dynamic userDateTimeOnBoard;
  final String number;
  final String userId;
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
    this.plataformId,
    this.userDateTimeOnBoard,
    this.number,
    this.userId,
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
    print('SetDocGroupCurrentAsyncGroupAction...');
    Firestore firestore = Firestore.instance;
    GroupModel groupModel = state.groupState.groupCurrent;
    groupModel.codigo = codigo;
    groupModel.plataformId = plataformId;
    groupModel.userDateTimeOnBoard = userDateTimeOnBoard;
    groupModel.number = number;
    groupModel.userId = userId;
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
        workerIdList: state.groupState.groupCurrent.workerIdList,
        moduleId: state.groupState.groupCurrent.moduleId,
      ));
    }
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
  void after() => dispatch(GetDocsGroupListAsyncGroupAction());
}

class SetModuleTheGroupSyncGroupAction extends ReduxAction<AppState> {
  final String id;
  SetModuleTheGroupSyncGroupAction({this.id});
  @override
  AppState reduce() {
    GroupModel groupModel = state.groupState.groupCurrent;
    groupModel.moduleId = id;
    return state.copyWith(
      groupState: state.groupState.copyWith(
        groupCurrent: groupModel,
      ),
    );
  }
}

class SetWorkerTheGroupSyncGroupAction extends ReduxAction<AppState> {
  final String id;
  final bool addOrRemove;
  SetWorkerTheGroupSyncGroupAction({
    this.id,
    this.addOrRemove,
  });
  @override
  AppState reduce() {
    GroupModel groupModel = state.groupState.groupCurrent;
    if (groupModel.workerIdList == null) groupModel.workerIdList = [];
    if (addOrRemove) {
      if (!groupModel.workerIdList.contains(id)) {
        groupModel.workerIdList.add(id);
        print('groupModel.workerIdList1: ${groupModel.workerIdList}');
        return state.copyWith(
          groupState: state.groupState.copyWith(
            groupCurrent: groupModel,
          ),
        );
      } else {
        print('groupModel.workerIdList2: ${groupModel.workerIdList}');
        return null;
      }
    } else {
      groupModel.workerIdList.remove(id);
      print('groupModel.workerIdList3: ${groupModel.workerIdList}');
      return state.copyWith(
        groupState: state.groupState.copyWith(
          groupCurrent: groupModel,
        ),
      );
    }
  }
}
