import 'package:mocktail/mocktail.dart';
import 'package:simple_crud/core/enviroment.dart';
import 'package:simple_crud/core/logger/logger.dart';
import 'package:simple_crud/data/datasources/local/database/acess_database.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../../core/dependency_injection/dependency_injection.test.dart';
import '../../../mocks/db_mocks.dart';

void main() {
  dependenciesTestSetup();
  group("Access Database >", () {
    final db = MockDb();
    final sut = AccessDatabaseImpl(db);
    const collection = "collection";
    final map = {"key": "value"};
    final dbCol = MockDbCollection();

    setUp(() {
      when(() => db.collection(collection)).thenReturn(dbCol);
    });

    test("When listAll, should return a Map with all results", () async {
      when(() => dbCol.find()).thenAnswer((_) => Stream.value(map));

      final result = await sut.listAll(collection);
      expect(result.length, 1);
      expect(result.first["key"], "value");
    });

    test("When save, should save and return an updated map", () async {
      final map2 = {...map};
      map2["key2"] = "value2";

      when(() => dbCol.insert(map)).thenAnswer((_) async => map2);

      final result = await sut.save(collection, map);
      expect(result, map2);
    });

    group("Create >", () {
      final dbHost = "0.0.0.0";
      final dbPort = 1234;
      bool dbOpened = false;
      when(() => getIt<Environment>().dbHost).thenReturn(dbHost);
      when(() => getIt<Environment>().dbPort).thenReturn(dbPort);

       test("When create fails, should log and rethrow", () async {
        try {
          final result =
              await AccessDatabaseImpl.create(spy: (_) => throw Exception());
          expect(result, isNull);
        } catch (e) {
          expect(e, isA<Exception>());
          verify(() =>
                  getIt<Logger>().debug("Cannot open database", any(), any()))
              .called(1);
        }
      });

      test("When create without spy, should just break", () async {
        try {
          final result =
              await AccessDatabaseImpl.create();
          expect(result, isNull);
        } catch (e) {
          expect(e, isA<Exception>());
        
        }
      });

      test("When create succeed, should return a valid implementation",
          () async {
        when(() => db.open()).thenAnswer((_) async {
          dbOpened = true;
          return dbOpened;
        });
        final result = await AccessDatabaseImpl.create(spy: (path) async {
          expect(path, "mongodb://$dbHost:$dbPort/crud");
          return db;
        });

        expect(result, isNotNull);
        expect(result.instance, db);
        expect(dbOpened, true);
      });
    });
  });
}
