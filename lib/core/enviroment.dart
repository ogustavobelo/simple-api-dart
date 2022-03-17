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
}
