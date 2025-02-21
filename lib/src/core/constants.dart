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
  static const String kAddressKey = 'address';
  static const String kCityKey = 'city';
  static const String kStateKey = 'state';
  static const String kCountryKey = 'country';
  static const String kPincodeKey = 'pincode';
  static const String kPhoneKey = 'phone';
  static const String kIsPhoneVerifiedKey = 'is_phone_verified';
  static const String kUserNameKey = 'user_name';
}
