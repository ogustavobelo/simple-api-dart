import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:test_process/test_process.dart';

void main() {
  group(
    "Server Test >",
    () {
      final port = '3000';
      final host = 'http://0.0.0.0:$port';

      setUp(() async {
        await TestProcess.start(
          'dart',
          [
            'run',
            "--define=IS_PROD=false --define=SERVER_PORT=$port "
                "--define=HOST=$host",
            'bin/server.dart',
          ],
        );
      });

      test('Root', () async {
        final response = await get(Uri.parse(host + '/'));
        expect(response.statusCode, 200);
        expect(response.body, 'Simple Crud Dart API!\n');
      });

      test('Users', () async {
        final response = await get(Uri.parse(host + '/users'),
            headers: {"Authorization": "Bearer test"});
        expect(response.statusCode, 200);
      });
      test('404', () async {
        final response = await get(Uri.parse(host + '/foobar'));
        expect(response.statusCode, 404);
      });
    },
  );
}
