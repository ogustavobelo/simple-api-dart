import 'package:simple_crud/data/datasources/local/database/dev_database.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group("Dev Database >", () {
    final sut = DevDatabase();
    final collection = "collection";
    final map = {"key": "value"};
    test("Should save a value", () async {
      final result = await sut.save(collection, map);
      expect(result, map);
    });

    test("Should list all values saved", () async {
      final map2 = {...map};
      map2["key2"] = "value2";
      await sut.save(collection, map2);

      final result = await sut.listAll(collection);
      expect(result.length, 2);
    });
  });
}
