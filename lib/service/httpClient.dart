import 'package:dio/dio.dart';

class HttpClient {
  static HttpClient? _instance;
  static late final Dio dio;
  final CancelToken _cancelToken = CancelToken();
  factory HttpClient() => _instance ??= HttpClient._internal();
  HttpClient._internal() {
    BaseOptions options = BaseOptions();

    dio = Dio(options);
  }

  /// 初始化 公共属性
  ///
  /// [baseUrl] 地址前缀
  /// [connectTimeout] 连接超时时间
  /// [receiveTimeout] 接受超时时间
  /// [headers] 请求头
  /// [interceptor] 基础拦截器
  ///
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
}
