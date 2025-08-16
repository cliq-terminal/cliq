import 'package:cliq/data/sqlite/database.dart';
import 'package:cliq/data/sqlite/repository.dart';
import 'package:drift/drift.dart';

final class HostRepository extends Repository<Hosts, Host> {
  const HostRepository(super.db);

  @override
  TableInfo<Hosts, Host> get table => db.hosts;
}
