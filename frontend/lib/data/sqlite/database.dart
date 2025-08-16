import 'package:cliq/data/sqlite/hosts/host_repository.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(include: {'hosts/hosts.drift'})
final class CliqDatabase extends _$CliqDatabase {
  static late HostRepository hostRepository;

  CliqDatabase([QueryExecutor? executor])
    : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static void init() {
    final db = CliqDatabase();
    hostRepository = HostRepository(db);
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'cliq_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
