import 'package:gemadale_app/env.dart';
import 'package:gemadale_app/service/HttpClient.dart';

class Http {
  static void init() {
    HttpClient().init(
      baseUrl: Env().envConfig.baseUrl,
      headers: {'content-type': 'application/json'},
    );
  }

  static Future get(
    String path, {
    Map<String, dynamic>? params,
  }) async {
    return await HttpClient().executeGet(
      url: path,
      params: params,
    );
  }
}
