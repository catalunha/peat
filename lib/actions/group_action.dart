import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peat/models/group_model.dart';
import 'package:peat/states/app_state.dart';

// +++ Actions Sync
class SetGroupCurrentSyncGroupAction extends ReduxAction<AppState> {
  final String id;

  SetGroupCurrentSyncGroupAction(this.id);

  @override
  AppState reduce() {
    print('SetGroupCurrentSyncGroupAction...');
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
        // .where('opened',isEqualTo: true)
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

class SetDocGroupCurrentAsyncGroupAction extends ReduxAction<AppState> {
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
  final List<dynamic> workerIdList;
  final dynamic created;
  final bool arquived;
  SetDocGroupCurrentAsyncGroupAction({
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
    this.workerIdList,
    this.created,
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
    groupModel.workerIdList = workerIdList;
    groupModel.created = FieldValue.serverTimestamp();
    groupModel.arquived = arquived;
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
