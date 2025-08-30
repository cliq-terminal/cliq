import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'credentials/credential_type.dart';

part 'database.g.dart';

@DriftDatabase(include: {
  'connections/connections.drift',
  'credentials/credentials.drift',
  'identities/identities.drift'
})
final class CliqDatabase extends _$CliqDatabase {
  CliqDatabase([QueryExecutor? executor])
    : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static void init() {
    final db = CliqDatabase();
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
