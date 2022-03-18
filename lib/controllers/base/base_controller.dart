import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:simple_crud/core/dependecy_injection/dependecy_injection.dart';
import 'package:simple_crud/core/logger/logger.dart';
import 'package:simple_crud/domain/entities/serializable/serializable.dart';

class BaseController {
  final logger = getIt<Logger>();

  Response success({Serializable? object, String? log}) {
    if (log != null) {
      logger.info(log);
    }
    return Response(200,
        body: object?.json != null ? json.encode(object!.json) : null);
  }

  Response message(String message) {
    return Response.ok(message);
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
