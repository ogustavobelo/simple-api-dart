import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:simple_crud/core/dependecy_injection/dependecy_injection.dart';
import 'package:simple_crud/core/logger/logger.dart';

class BaseController {
  final logger = getIt<Logger>();

  Response success({Map<String, dynamic>? aJson, String? message}) {
    if (message != null) logger.info(message);
    return Response(200, body: aJson != null ? json.encode(aJson) : null);
  }

  Response error(
    String message, {
    Map<String, dynamic>? parameters,
    Object? error,
    StackTrace? stackTrace,
  }) {
    logger.debug(message, error, stackTrace);
    return Response(400,
        body: json.encode({
          "error": message,
          if (parameters != null) ...parameters,
        }));
  }
}
