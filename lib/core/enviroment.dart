import 'dart:io';

const _kHost = '0.0.0.0';
const _kDatabaseHost = '0.0.0.0';
const _kServerPort = 3000;
const _kDatabasePort = 27017;
const _kJWTKey = 'JWT_SECRET_KEY';
const _kJWTIssure = 'JWT_ISSURE';

abstract class Environment {
  bool get isProd;
  String get host;
  int get serverPort;
  String get dbHost;
  int get dbPort;
  String get jwtKey;
  String get jwtIssure;
}

class EnvironmentBuild implements Environment {
  static const bool _isProd = bool.fromEnvironment("IS_PROD");
  @override
  bool get isProd => _isProd;

  static const String _host =
      String.fromEnvironment("HOST", defaultValue: _kHost);
  @override
  String get host => _host;

  static const int _serverPort =
      int.fromEnvironment("SERVER_PORT", defaultValue: _kServerPort);
  @override
  int get serverPort => _serverPort;

  static const int _dbPort =
      int.fromEnvironment("DATABASE_PORT", defaultValue: _kDatabasePort);
  @override
  int get dbPort => _dbPort;

  static const String _dbHost =
      String.fromEnvironment("DATABASE_HOST", defaultValue: _kDatabaseHost);
  @override
  String get dbHost => _dbHost;

  static const String _jwtKey =
      String.fromEnvironment("JWT_SECRET_KEY", defaultValue: _kJWTKey);
  @override
  String get jwtKey => _jwtKey;

  static const String _jwtIssure =
      String.fromEnvironment("JWT_ISSURE", defaultValue: _kJWTIssure);
  @override
  String get jwtIssure => _jwtIssure;
}

class EnvironmentPlatform implements Environment {
  @override
  bool get isProd => Platform.environment['IS_PROD'] == "true";

  @override
  String get host => Platform.environment['HOST'] ?? _kHost;

  @override
  int get serverPort =>
      int.tryParse(Platform.environment['SERVER_PORT'] ?? "") ?? _kServerPort;

  @override
  int get dbPort =>
      int.tryParse(Platform.environment['DATABASE_PORT'] ?? "") ??
      _kDatabasePort;

  @override
  String get dbHost => Platform.environment['DATABASE_HOST'] ?? _kDatabaseHost;

  @override
  String get jwtKey => Platform.environment['JWT_SECRET_KEY'] ?? _kJWTKey;

  @override
  String get jwtIssure => Platform.environment['JWT_ISSURE'] ?? _kJWTIssure;
}
