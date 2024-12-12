enum AppRoutes {
  // splash
  splashPage,

  // auth
  loginPage,
  setupProfilePage,
  profileCompleted,

  // home
  homePage,

  // chat
  chatScreen,
}

extension PathName on AppRoutes {
  String get path => switch (this) { AppRoutes.homePage => "/", _ => "/$name" };
}
