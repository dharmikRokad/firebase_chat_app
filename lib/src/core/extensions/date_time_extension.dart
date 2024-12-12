import 'package:intl/intl.dart';

extension FormateExtension on DateTime {
  String get ddMMyyyy {
    final DateFormat fromat = DateFormat('dd/MM/yyyy');
    return fromat.format(this);
  }

  String get ddMonYYYY {
    final DateFormat fromat = DateFormat('dd MMM yyyy');
    return fromat.format(this);
  }
}
