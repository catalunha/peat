enum AuthenticationStatusLogged {
  unInitialized,
  authenticated,
  authenticating,
  unAuthenticated,
  sendPasswordReset,
}

//+++ UserOrder
enum UserOrder {
  sispat,
  displayName,
  plataformRefOnBoard,
  dateTimeOnBoard,
}

extension UserOrderExtension on UserOrder {
  static const names = {
    UserOrder.sispat: 'SISPAT',
    UserOrder.displayName: 'Nome',
    UserOrder.plataformRefOnBoard: 'Plataforma',
    UserOrder.dateTimeOnBoard: 'DataOnBoard',
  };
  String get name => names[this];
}
//--- UserOrder

//+++ PlataformOrder
enum PlataformOrder {
  codigo,
}

extension PlataformOrderExtension on PlataformOrder {
  static const names = {
    PlataformOrder.codigo: 'Código',
  };
  String get name => names[this];
}
//--- PlataformOrder

//+++ PlataformOrder
enum ModuleOrder {
  codigo,
}

extension ModuleOrderExtension on ModuleOrder {
  static const names = {
    ModuleOrder.codigo: 'Código',
  };
  String get name => names[this];
}
//--- ModuleOrder

//+++ UserOrder
enum WorkerOrder {
  sispat,
  displayName,
  company,
  activity,
}

extension WorkerOrderExtension on WorkerOrder {
  static const names = {
    WorkerOrder.sispat: 'SISPAT',
    WorkerOrder.displayName: 'Nome',
    WorkerOrder.company: 'Empresa',
    WorkerOrder.activity: 'Função',
  };
  String get name => names[this];
}
//--- WorkerOrder

//+++ PlataformOrder
enum GroupOrder {
  codigo,
  startCourse,
  localCourse,
}

extension GroupOrderExtension on GroupOrder {
  static const names = {
    GroupOrder.codigo: 'Código',
    GroupOrder.startCourse: 'Início',
    GroupOrder.localCourse: 'Local',
  };
  String get name => names[this];
}
//--- GroupOrder
