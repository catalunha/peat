import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peat/models/module_model.dart';
import 'package:peat/states/app_state.dart';
import 'package:peat/states/types_states.dart';

// +++ Actions Sync
class SetModuleCurrentSyncModuleAction extends ReduxAction<AppState> {
  final String id;

  SetModuleCurrentSyncModuleAction(this.id);

  @override
  AppState reduce() {
    ModuleModel moduleModel = id == null
        ? ModuleModel(null)
        : state.moduleState.moduleList
            .firstWhere((element) => element.id == id);
    return state.copyWith(
      moduleState: state.moduleState.copyWith(
        moduleCurrent: moduleModel,
      ),
    );
  }
}

class SetModuleOrderSyncUserAction extends ReduxAction<AppState> {
  final ModuleOrder moduleOrder;

  SetModuleOrderSyncUserAction(this.moduleOrder);
  @override
  AppState reduce() {
    List<ModuleModel> _moduleList = [];
    _moduleList.addAll(state.moduleState.moduleList);
    if (moduleOrder == ModuleOrder.codigo) {
      _moduleList.sort((a, b) => a.codigo.compareTo(b.codigo));
    }
    return state.copyWith(
      moduleState: state.moduleState.copyWith(
        moduleOrder: moduleOrder,
        moduleList: _moduleList,
      ),
    );
  }
}

// +++ Actions Async
class GetDocsModuleListAsyncModuleAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    print('GetDocsModuleListAsyncModuleAction...');
    Firestore firestore = Firestore.instance;

    final collRef = firestore.collection(ModuleModel.collection);
    final docsSnap = await collRef.getDocuments();

    final listDocs = docsSnap.documents
        .map((docSnap) => ModuleModel(docSnap.documentID).fromMap(docSnap.data))
        .toList();
    return state.copyWith(
      moduleState: state.moduleState.copyWith(
        moduleList: listDocs,
      ),
    );
  }
}

class CreateDocModuleCurrentAsyncModuleAction extends ReduxAction<AppState> {
  final String codigo;
  final String description;
  final String urlFolder;

  CreateDocModuleCurrentAsyncModuleAction({
    this.codigo,
    this.description,
    this.urlFolder,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocModuleCurrentAsyncModuleAction...');
    Firestore firestore = Firestore.instance;
    ModuleModel moduleModel = state.moduleState.moduleCurrent.copy();
    moduleModel.codigo = codigo;
    moduleModel.description = description;
    moduleModel.urlFolder = urlFolder;
    moduleModel.arquived = false;
    var docRef = await firestore
        .collection(ModuleModel.collection)
        .where('codigo', isEqualTo: codigo)
        .getDocuments();
    bool doc = docRef.documents.length != 0;
    if (doc) throw const UserException("Esta módulo já foi cadastrado.");
    await firestore
        .collection(ModuleModel.collection)
        .document(moduleModel.id)
        .setData(moduleModel.toMap(), merge: true);
    return state.copyWith(
      moduleState: state.moduleState.copyWith(
        moduleCurrent: moduleModel,
      ),
    );
  }

  @override
  Object wrapError(error) => UserException("ATENÇÃO:", cause: error);
  @override
  void after() => dispatch(GetDocsModuleListAsyncModuleAction());
}

class UpdateDocModuleCurrentAsyncModuleAction extends ReduxAction<AppState> {
  final String codigo;
  final String description;
  final String urlFolder;
  final bool arquived;

  UpdateDocModuleCurrentAsyncModuleAction({
    this.codigo,
    this.description,
    this.urlFolder,
    this.arquived,
  });
  @override
  Future<AppState> reduce() async {
    print('SetDocModuleCurrentAsyncModuleAction...');
    Firestore firestore = Firestore.instance;
    ModuleModel moduleModel = state.moduleState.moduleCurrent.copy();
    moduleModel.codigo = codigo;
    moduleModel.description = description;
    moduleModel.urlFolder = urlFolder;
    moduleModel.arquived = arquived;
    await firestore
        .collection(ModuleModel.collection)
        .document(moduleModel.id)
        .updateData(moduleModel.toMap());
    return state.copyWith(
      moduleState: state.moduleState.copyWith(
        moduleCurrent: moduleModel,
      ),
    );
  }

  @override
  void after() => dispatch(GetDocsModuleListAsyncModuleAction());
}
