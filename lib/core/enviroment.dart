import 'dart:io';

const _host = '0.0.0.0';
const _databaseHost = '0.0.0.0';
const _serverPort = 3000;
const _databasePort = 27017;

class Environment {
  final bool isProd;
  final String host;
  final int serverPort;
  final String dbHost;
  final int dbPort;

  const Environment({
    required this.serverPort,
    required this.dbPort,
    required this.dbHost,
    required this.host,
    this.isProd = false,
  });

  static Environment fromEnv() {
    final host = Platform.environment['HOST'] ?? _host;
    final dbHost = Platform.environment['DATABASE_HOST'] ?? _databaseHost;
    final serverPort = int.tryParse(Platform.environment['SERVER_PORT'] ?? "") ?? _serverPort;
    final dbPort = int.tryParse(Platform.environment['DATABASE_PORT'] ?? "") ?? _databasePort;
    return Environment(
      serverPort: serverPort,
      dbPort: dbPort,
      dbHost: dbHost,
      host: host,
    );
  }

  static Environment fromBuild() {
    const bool isProd = bool.fromEnvironment("IS_PROD");
    const String host = String.fromEnvironment("HOST", defaultValue: _host);
    const int serverPort = int.fromEnvironment("SERVER_PORT");
    const int dbPort = int.fromEnvironment("DATABASE_PORT", defaultValue: _databasePort);
    const String dbHost = String.fromEnvironment("DATABASE_HOST", defaultValue: _databaseHost);
    return Environment(
      isProd: isProd,
      host: host,
      dbPort: dbPort,
      dbHost: dbHost,
      serverPort: serverPort,
    );
  }
}
