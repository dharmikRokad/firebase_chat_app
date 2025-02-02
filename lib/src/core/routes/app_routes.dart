enum AppRoutes {
  // splash ================================
  splashPage,

  // auth ================================
  loginPage,
  setupProfile,
  profileCompleted,

  // home ================================
  tabs,

  // chats ================================
  chats,
  chatScreen,

  // Profile ================================
  profile
}

extension PathName on AppRoutes {
  String get path => switch (this) { AppRoutes.chats => "/", _ => "/$name" };
}
