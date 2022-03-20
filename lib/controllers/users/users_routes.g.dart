// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_routes.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$UsersPrivateControllerRouter(UsersPrivateController service) {
  final router = Router();
  router.add('GET', r'/', service.listUsers);
  router.add('GET', r'/renew_token/<id>', service._generateToken);
  return router;
}

Router _$UsersPublicControllerRouter(UsersPublicController service) {
  final router = Router();
  router.add('POST', r'/', service._createUser);
  return router;
}
