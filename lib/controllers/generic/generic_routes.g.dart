// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_routes.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$GenericControllerRouter(GenericController service) {
  final router = Router();
  router.add('GET', r'/', service._rootHandler);
  router.all(r'/<ignored|.*>', service._notFound);
  return router;
}
