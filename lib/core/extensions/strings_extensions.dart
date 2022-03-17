import 'package:mongo_dart/mongo_dart.dart';

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
