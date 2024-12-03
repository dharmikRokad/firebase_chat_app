import 'package:intl/date_symbols.dart';

abstract class AppAsset {
  String get path => 'assets';
}

class AnimationAppAsset extends AppAsset {
  static final AnimationAppAsset _instance = AnimationAppAsset._();
  AnimationAppAsset._();
  factory AnimationAppAsset() => _instance;

  @override
  String get path => 'assets/animations';

  String get completedProfile => '$path/completed_animation.json';
}

class ImagesAppAsset extends AppAsset {
  static final ImagesAppAsset _instance = ImagesAppAsset._();
  ImagesAppAsset._();
  factory ImagesAppAsset() => _instance;

  @override
  String get path => 'assets/images';
}
