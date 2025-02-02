abstract class AppAsset {
  final String path = 'assets';
}

class AnimationAppAsset extends AppAsset {
  static final AnimationAppAsset _instance = AnimationAppAsset._();
  AnimationAppAsset._();
  factory AnimationAppAsset() => _instance;

  @override
  String get path => '${super.path}/animations';

  String get completedProfile => '$path/completed_animation.json';
  String get noInternet => '$path/no_connection_dog.json';
}

class ImagesAppAsset extends AppAsset {
  static final ImagesAppAsset _instance = ImagesAppAsset._();
  ImagesAppAsset._();
  factory ImagesAppAsset() => _instance;

  @override
  String get path => '${super.path}/images';

  String get attechment => '$path/attechment.png';
  String get audioCcall => '$path/audio_call.png';
  String get back => '$path/back.png';
  String get bell => '$path/bell.png';
  String get call => '$path/call.png';
  String get settings => '$path/settings.png';
  String get camera => '$path/camera.png';
  String get contact => '$path/contact.png';
  String get delete => '$path/delete.png';
  String get document => '$path/document.png';
  String get gallery => '$path/gallery.png';
  String get location => '$path/location.png';
  String get messages => '$path/messages.png';
  String get microphone => '$path/microphone.png';
  String get more => '$path/more.png';
  String get play => '$path/play.png';
  String get poll => '$path/poll.png';
  String get search => '$path/search.png';
  String get send => '$path/send.png';
  String get videoCall => '$path/video_call.png';
}
