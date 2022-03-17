import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'generic_routes.g.dart';

class GenericController {
  @Route.get('/')
  Response _rootHandler(Request req) {
    return Response.ok('Simple Crud Dart API!\n');
  }

  Router get router => _$GenericControllerRouter(this);
}
