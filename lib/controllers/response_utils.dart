import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';

@injectable
class ResponseUtils {
  const ResponseUtils();
  Response success(Map<String, dynamic> aJson) {
    return Response(200, body: json.encode(aJson));
  }

  Response error(String message, {Map<String, dynamic>? parameters}) {
    return Response(400,
        body: json.encode({
          "error": message,
          if (parameters != null) ...parameters,
        }));
  }
}
