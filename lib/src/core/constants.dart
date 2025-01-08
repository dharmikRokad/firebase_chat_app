class Consts {
  static final RegExp emailReg =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  // supabase storage keys
  static const String kImagesBucket = 'images';
  static const String kProfilePicsFolder = 'profile_pics';
  static String kChatImagesFolder(String id) => 'chat_images/$id';

  // user table
  static const String kUsersTable = 'users';
  static const String kIdKey = 'id';
  static const String kEmailKey = 'email';
  static const String kFNameKey = 'fname';
  static const String kLNameKey = 'lname';
  static const String kProfessionKey = 'profession';
  static const String kBirthDateKey = 'birth_date';
  static const String kGenderKey = 'gender';
  static const String kProfilePicKey = 'profile_pic';

  // Shared Preferences
  static const String kThemeKey = 'theme';
}
