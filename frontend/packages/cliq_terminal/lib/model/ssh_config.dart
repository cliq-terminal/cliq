import 'package:dartssh2/dartssh2.dart';

class CliqSSHConfig {
  final String host;
  final String user;
  final int port;
  final String? password;
  final List<SSHKeyPair>? identities;

  CliqSSHConfig({
    required this.host,
    required this.user,
    this.port = 22,
    this.password,
    this.identities,
  });
}