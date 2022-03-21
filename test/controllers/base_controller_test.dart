import 'package:simple_crud/controllers/base/base_controller.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../core/dependency_injection/dependency_injection.test.dart';
import '../fixtures/serialized_user_fixture.dart';

void main() {
  dependenciesTestSetup();
  group("BaseController >", () {
    final sut = BaseController();
    final serializable = SerializedUserFixture.user;
    test("Should return a successful response", () {
      final result = sut.success(object: serializable);
      expect(result.statusCode, 200);
    });
    test("Should return a error response", () {
      final result = sut.error("error");
      expect(result.statusCode, 400);
    });
    test("Should return a OK response", () async {
      final result = sut.message("message");
      expect(result.statusCode, 200);
      final message = await result.readAsString();
      expect(message, "message");
    });
  });
}
