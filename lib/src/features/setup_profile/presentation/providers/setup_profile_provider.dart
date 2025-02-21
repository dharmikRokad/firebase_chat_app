import 'dart:io' show File;

import 'package:chat_app/src/chat_app_injector.dart' show sl;
import 'package:chat_app/src/core/constants.dart';
import 'package:chat_app/src/core/shared_prefs.dart';
import 'package:chat_app/src/core/strings.dart';
import 'package:chat_app/src/features/setup_profile/domain/usecases/send_otp_usecase.dart';
import 'package:chat_app/src/features/setup_profile/domain/usecases/update_profile_usecase.dart';
import 'package:chat_app/src/features/setup_profile/domain/usecases/verify_otp_usecase.dart';
import 'package:chat_app/src/services/supa_storage_service.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SetupProfileProvider extends ChangeNotifier {
  final SendOtpUsecase sendOtpUsecase;
  final VerifyOtpUsecase verifyOtpUsecase;
  final UpdateProfileUsecase updateProfileUseCase;

  SetupProfileProvider({
    required this.sendOtpUsecase,
    required this.verifyOtpUsecase,
    required this.updateProfileUseCase,
  });

  // Class Fields ================================
  bool _isLoading = false;
  XFile? _profilePic;
  DateTime? _dob;
  String? _gender;
  String? _city;
  String? _state;
  String? _country;
  Country _phoneCountry = CountryService().findByCode('IN')!;

  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController proffesionController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  // Getters ================================
  bool get isLaoding => _isLoading;
  XFile? get profilePic => _profilePic;
  DateTime? get dob => _dob;
  String? get gender => _gender;

  String? get city => _city;
  String? get state => _state;
  String? get country => _country;
  Country get phoneCountry => _phoneCountry;
  String get fullPhone => "+${phoneCountry.phoneCode} ${phoneController.text}";

  // Setter Functions ================================
  void changeLoading(bool newValue) {
    _isLoading = newValue;
    notifyListeners();
  }

  void setProfilePic(XFile? value) {
    _profilePic = value;
    notifyListeners();
  }

  void setDob(DateTime? value) {
    _dob = value;
    notifyListeners();
  }

  void setGender(String? value) {
    _gender = value;
    notifyListeners();
  }

  void changeCity(String? value) {
    _city = value;
    notifyListeners();
  }

  void changeState(String? value) {
    _state = value;
    notifyListeners();
  }

  void changeCountry(String? value) {
    _country = value;
    notifyListeners();
  }

  void changePhoneCountry(Country newVal) {
    _phoneCountry = newVal;
    notifyListeners();
  }

  void resetValues() {
    _profilePic = null;
    _dob = null;
    _gender = null;
    _city = null;
    _state = null;
    _phoneCountry = CountryService().findByCode('IN')!;
    addressController.clear();
    pinController.clear();
    fnameController.clear();
    lNameController.clear();
    proffesionController.clear();
    usernameController.clear();
    phoneController.clear();
    dobController.clear();
    notifyListeners();
  }

  // Class Functions ================================

  Future<void> sendOtp({
    Function(String)? onSuccess,
    Function(String)? onFailure,
  }) async {
    changeLoading(true);

    final result = await sendOtpUsecase(fullPhone);

    if (!result) {
      onFailure?.call('Semething went wrong');
    }

    changeLoading(false);
  }

  Future<void> verifyOtp(
    String otp, {
    Function(String)? onSuccess,
    Function(String)? onFailure,
  }) async {
    changeLoading(true);

    final result = await verifyOtpUsecase((fullPhone, otp));

    if (result) {
      onSuccess?.call("OTP Verified.");
    } else {
      onFailure?.call('Enter valid OTP.');
    }

    changeLoading(false);
  }

  Future<void> updateProfile(
    String uid,
    String email, {
    Function(String)? onSuccess,
    Function(String)? onFailure,
  }) async {
    changeLoading(true);

    final profilePicUrl = await sl<SupaStorageService>().uploadProfilePic(
      file: File(profilePic?.path ?? ''),
      path: '${Consts.kProfilePicsFolder}/${sl<SharedPrefs>().user?.id}',
      accessToken: sl<SharedPrefs>().accessToken ?? '',
    );

    if (profilePicUrl == null) return;

    final result = await updateProfileUseCase(
      UpdateProfileParams(
        uid: uid,
        email: email,
        data: {
          Consts.kFNameKey: fnameController.text,
          Consts.kLNameKey: lNameController.text,
          Consts.kProfessionKey: proffesionController.text,
          Consts.kBirthDateKey: dobController.text,
          Consts.kUserNameKey: usernameController.text,
          Consts.kGenderKey: gender,
          Consts.kPhoneKey: fullPhone,
          Consts.kIsPhoneVerifiedKey: true,
          Consts.kProfilePicKey: profilePicUrl,
          Consts.kAddressKey: {
            Consts.kAddressKey: addressController.text,
            Consts.kCityKey: city,
            Consts.kStateKey: state,
            Consts.kCountryKey: country,
            Consts.kPincodeKey: pinController.text,
          },
        },
      ),
    );

    result.fold(
      (err) => onFailure?.call(err.toString()),
      (value) => onSuccess?.call(Strings.profileUpdated),
    );

    changeLoading(true);
  }
}
