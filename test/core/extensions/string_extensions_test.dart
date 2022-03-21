import 'package:mongo_dart/mongo_dart.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:simple_crud/core/extensions/strings_extensions.dart';

void main() {
  group("StringExtensions >", () {
    test("When is empty or null should return true", () {
      final empty = "";
      final notEmptyNull = "full";
      final String? nullable = null;
      expect(empty.isEmptyOrNull, true);
      expect(nullable.isEmptyOrNull, true);
      expect(notEmptyNull.isEmptyOrNull, false);
    });

    test("Should return a valid uid v4", (){
      final uid = StringUtils.uuid();
      expect(Uuid.isValidUUID(fromString: uid), true);
    });
  });
}
