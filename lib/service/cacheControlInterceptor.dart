import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class CacheControlInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    Logger().d('onRequest $options');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    Logger().d('onResponse');
    super.onResponse(response, handler);
  }
}
