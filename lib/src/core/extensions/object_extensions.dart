import 'dart:developer' as d;

extension ObjectLogExtension on Object {
  void log(String msg) {
    return d.log(msg, name: runtimeType.toString());
  }
}
