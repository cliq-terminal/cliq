import 'dart:convert';
import 'dart:typed_data';
import 'package:dartssh2/dartssh2.dart';

import 'package:cliq_terminal/cliq_terminal.dart';

class CliqTerminal {
  final SSHClient client;
  final SSHSession session;

  const CliqTerminal._internal(this.client, this.session);

  static Future<CliqTerminal> connect(
    CliqSSHConfig config, {
    Function(Uint8List)? onStdout,
    Function(Uint8List)? onStderr,
  }) async {
    final client = await _createClient(config);
    final shell = await client.shell();
    shell.stdout.listen((data) {
      /* TODO: investigate nano & exit */
      onStdout?.call(data);
    });
    shell.stderr.listen(onStderr ?? (data) {});
    return CliqTerminal._internal(client, shell);
  }

  static Future<String> runOnce(CliqSSHConfig config, String command) {
    return _createClient(config)
        .then((client) => client.run(command))
        .then((result) => utf8.decode(result));
  }

  void write(dynamic data) {
    switch (data) {
      case String s:
        session.write(utf8.encode(s));
      case Uint8List bytes:
        session.write(bytes);
    }
  }

  /* TODO: check kill signals */
  void kill({SSHSignal killSignal = SSHSignal.KILL}) =>
      session.kill(killSignal);

  void resize(int width, int height) {
    session.resizeTerminal(width, height);
  }

  static Future<SSHClient> _createClient(CliqSSHConfig config) async {
    return SSHClient(
      await SSHSocket.connect(config.host, config.port),
      username: config.user,
      onPasswordRequest: config.password != null ? () => config.password : null,
      identities: config.identities,
    );
  }
}
