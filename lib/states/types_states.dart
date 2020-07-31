enum AuthenticationStatusLogged {
  unInitialized,
  authenticated,
  authenticating,
  unAuthenticated,
  sendPasswordReset,
}
//+++ UserFilter
enum UserFilter {
  sispat,
  displayName,
  plataformIdOnBoard,
  dateTimeOnBoard,
}

extension UserFilterExtension on UserFilter {
  static const names = {
    UserFilter.sispat: 'SISPAT',
    UserFilter.displayName: 'Nome',
    UserFilter.plataformIdOnBoard: 'Plataforma',
    UserFilter.dateTimeOnBoard: 'DataOnBoard',
  };
  String get name => names[this];
}

//--- UserFilter
