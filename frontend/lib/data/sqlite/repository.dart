import 'package:cliq/data/sqlite/database.dart';
import 'package:drift/drift.dart';

abstract class Repository<T extends Table, R> {
  final CliqDatabase db;

  const Repository(this.db);

  TableInfo<T, R> get table;

  Future<List<R>> findAll() => db.select<T, R>(table).get();

  Future<R?> findById(int id) =>
      (db.select(table)..where((row) => _whereId(row, id))).getSingleOrNull();

  Future<int> insert(UpdateCompanion<R> row) => db.into(table).insert(row);

  Future<void> insertAll(List<UpdateCompanion<R>> rows) =>
      db.batch((batch) => batch.insertAll(table, rows));

  Future<int> update(UpdateCompanion<R> row) => db.update(table).write(row);

  Future<void> deleteById(int id) =>
      (db.delete(table)..where((row) => _whereId(row, id))).go();

  Future<void> deleteAll() => db.delete(table).go();

  Expression<bool> _whereId(T row, int id) {
    final idColumn = table.columnsByName['id'];

    if (idColumn == null) {
      throw ArgumentError.value(
        this,
        'this',
        'Must be a table with an id column',
      );
    }

    if (idColumn.type != DriftSqlType.int) {
      throw ArgumentError('Column `id` is not an integer');
    }

    return idColumn.equals(id);
  }
}
