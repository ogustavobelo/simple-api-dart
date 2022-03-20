import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:test_process/test_process.dart';

import 'core/dependency_injection/dependency_injection.test.dart';

void main() {
  dependenciesTestSetup();
  group(
    "Server Test >",
    () {
      final port = '3000';
      final serverHost = "0.0.0.0";
      final host = 'http://$serverHost:$port';

      setUp(() async {
        await TestProcess.start(
          'dart',
          [
            'run',
            "--define=IS_PROD=false --define=SERVER_PORT=$port "
                "--define=HOST=$serverHost",
            'bin/server.dart',
          ],
        );
      });

      test('Root', () async {
        final response = await get(Uri.parse(host + '/'));
        expect(response.statusCode, 200);
        expect(response.body, 'Simple Crud Dart API!\n');
      });

      test('Users > When has a invalida token, should return 403', () async {
        final response = await get(Uri.parse(host + '/users/'),
            headers: {"Authorization": "Bearer test"});
        expect(response.statusCode, 403);
      });
      test('404', () async {
        final response = await get(Uri.parse(host + '/foobar'));
        expect(response.statusCode, 404);
      });
    },
  );
}
