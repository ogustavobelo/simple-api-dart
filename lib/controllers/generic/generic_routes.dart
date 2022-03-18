import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:simple_crud/controllers/base/base_controller.dart';

part 'generic_routes.g.dart';

class GenericController extends BaseController {
  @Route.get('/')
  Response _rootHandler(Request req) {
    return success(message: 'Simple Crud Dart API!\n');
  }

  Router get router => _$GenericControllerRouter(this);
}
