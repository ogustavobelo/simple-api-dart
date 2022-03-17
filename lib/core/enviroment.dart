class Environment {
  final bool isProd;
  final int serverPort;
  final int dbPort;
  final String host;

  const Environment({
    required this.serverPort,
    required this.dbPort,
    required this.host,
    this.isProd = false,
  });
}
