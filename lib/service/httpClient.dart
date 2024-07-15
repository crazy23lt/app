import 'package:dio/dio.dart';
import 'package:gemadale_app/service/CacheControlInterceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// 1.集中的单例的管理网络请求实例，避免多实例浪费内存。
/// 2.抽取网络请求引擎，方便后期更换网络请求框架。
/// 3.封装简化请求参数，简化请求流程，方便添加公共逻辑。
/// 4.可用拦截器的方式抽离各项子功能，面向切面编程。
class HttpClient {
  static HttpClient? _instance;
  static late final Dio dio;
  final CancelToken _cancelToken = CancelToken();
  factory HttpClient() => _instance ??= HttpClient._internal();
  HttpClient._internal() {
    BaseOptions options = BaseOptions();
    dio = Dio(options);
    // 日志格式化
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));
    dio.interceptors.add(CacheControlInterceptor());
  }

  void init({
    String? baseUrl,
    int connectTimeout = 1500,
    int receiveTimeout = 1500,
    Map<String, String>? headers,
    List<Interceptor>? interceptors,
  }) {
    dio.options = dio.options.copyWith(
      baseUrl: baseUrl,
      connectTimeout: Duration(milliseconds: connectTimeout),
      receiveTimeout: Duration(milliseconds: receiveTimeout),
      headers: headers ?? {},
    );
    if (interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }
  }

  /// 取消请求
  void cancelRequest({required CancelToken token}) {
    _cancelToken.cancel('cancelled');
  }

  /// 网络请求 post
  Future<Response> executePost({
    required String url,
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    CancelToken? cancelToken,
  }) {
    final formData = FormData.fromMap(params ?? {});
    return dio.post(
      url,
      data: formData,
      options: Options(headers: headers),
      cancelToken: cancelToken,
    );
  }

  /// 网络请求 get
  Future<Response> executeGet({
    required String url,
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    CancelToken? cancelToken,
  }) {
    return dio.get(
      url,
      queryParameters: params,
      options: Options(headers: headers),
      cancelToken: cancelToken,
    );
  }
}
