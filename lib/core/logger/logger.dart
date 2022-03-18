import 'package:logger/logger.dart' as pkg;

abstract class Logger {
  void debug(String message, [dynamic error, StackTrace? st]);
  void info(String message);
}

class LoggerImpl implements Logger {
  final void Function(String, dynamic, StackTrace?) debugCallback;
  final void Function(String) infoCallback;
  const LoggerImpl({
    required this.debugCallback,
    required this.infoCallback,
  });

  static LoggerImpl create() {
    final logger = pkg.Logger();
    return LoggerImpl(
      debugCallback: (message, error, st) => logger.e(message, error, st),
      infoCallback: (message) => logger.i(message),
    );
  }

  @override
  void debug(String message, [dynamic error, StackTrace? st]) {
    debugCallback(message, error, st);
  }

  @override
  void info(String message) {
    infoCallback(message);
  }
}
