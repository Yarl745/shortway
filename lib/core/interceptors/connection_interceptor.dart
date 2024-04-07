import 'package:dio/dio.dart';
import 'package:shortway/core/error/exceptions.dart';
import 'package:shortway/core/network/network_connection_stream.dart';

/// Intercepts network requests to manage connection status.
///
/// This class extends Dio's Interceptor to monitor network requests and
/// responses, updating the app's connection status accordingly.
class ConnectionInterceptor extends Interceptor {
  const ConnectionInterceptor({
    required NetworkConnectionStream connectionStream,
  }) : _connectionStream = connectionStream;
  final NetworkConnectionStream _connectionStream;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _connectionStream.setConnectionStatus(true);
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (timeoutExceptionTypes.contains(err.type)) {
      _connectionStream.setConnectionStatus(false);
    }
    super.onError(err, handler);
  }
}
