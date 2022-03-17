// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_routes.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$UsersControllerRouter(UsersController service) {
  final router = Router();
  router.add('GET', r'/users', service.listUsers);
  router.add('GET', r'/users/<id>', service._listUser);
  router.add('PUT', r'/users/<id>', service._updateUser);
  router.add('DELETE', r'/users/<id>', service._deleteUser);
  router.add('POST', r'/users', service._createUser);
  router.all(r'/<ignored|.*>', service._notFound);
  return router;
}
