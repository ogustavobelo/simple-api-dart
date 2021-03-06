import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:simple_crud/controllers/base/base_controller.dart';

part 'generic_routes.g.dart';

class GenericController extends BaseController {
  @Route.get('/')
  Response _rootHandler(Request req) {
    return message('Simple Crud Dart API!\n');
  }

  @Route.all('/<ignored|.*>')
  Response _notFound(Request request) => Response.notFound('Page not found');

  Router get router => _$GenericControllerRouter(this);
}
