import 'dart:async';

import 'package:injectable/injectable.dart' hide Environment;
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shelf/shelf.dart';
import 'package:simple_crud/core/dependecy_injection/dependecy_injection.dart';
import 'package:simple_crud/core/enviroment.dart';

const _audience = "Simple_Crud_Dart";

@injectable
class AuthMiddleware {
  final env = getIt<Environment>();
  Middleware jwt() => (innerHandler) {
        return (request) {
          return Future.sync(() => innerHandler(request)).then((response) {
            if (!validateToken(request.headers["authorization"] ?? "")) {
              return Response.forbidden("Invalid Token");
            }
            return response;
          }, onError: (Object error, StackTrace stackTrace) {
            return Response.internalServerError();
          });
        };
      };

  bool validateToken(String token) {
    try {
      final String cleanToken = token.replaceAll('Bearer ', '');
      final JwtClaim claim = verifyJwtHS256Signature(cleanToken, env.jwtKey);
      claim.validate(issuer: env.jwtIssure, audience: _audience);
      return true;
    } catch (_) {
      return false;
    }
  }
}

class JwtAuthUtils {
  static String auth(String uid) {
    try {
      final env = getIt<Environment>();

      final JwtClaim claim = JwtClaim(
        subject: uid,
        issuer: env.jwtIssure,
        audience: [_audience],
        expiry: DateTime.now().add(Duration(days: 30)),
      );

      return issueJwtHS256(claim, env.jwtKey);
    } catch (_) {
      rethrow;
    }
  }
}
