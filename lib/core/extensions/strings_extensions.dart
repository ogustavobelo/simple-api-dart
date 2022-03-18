import 'package:uuid/uuid.dart';

extension StringExtension on String? {
  bool get isEmptyOrNull {
    return (this ?? "").isEmpty;
  }
}

class StringUtils {
  static String uuid() {
    return Uuid().v4();
  }
}
