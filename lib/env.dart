abstract class EnvName {
  // 环境key
  static const String envKey = "DART_DEFINE_APP_ENV";
  // 环境value
  static const String develop = "develop";
  static const String release = "release";
  static const String test = "test";
  static const String demo = "demo";
  static const String exhibition = "exhibition";
}

class EnvConfig {
  EnvConfig(
      {required this.appTitle,
      required this.baseUrl,
      required this.webviewUrl});
  final String appTitle;
  final String baseUrl;
  final String webviewUrl;
}

class Env {
  static Env? _instance;

  factory Env() => _instance ??= Env._internal();

  Env._internal() {
    appEnv = const String.fromEnvironment(EnvName.envKey);
    switch (appEnv) {
      case EnvName.develop:
        envConfig = _developCfg;
        break;
      case EnvName.release:
        envConfig = _releaseCfg;
        break;
      case EnvName.test:
        envConfig = _testCfg;
        break;
      case EnvName.demo:
        envConfig = _demoCfg;
        break;
      case EnvName.exhibition:
        envConfig = _exhibitionCfg;
        break;
      default:
        envConfig = _developCfg;
        break;
    }
  }

  late String appEnv;
  late EnvConfig envConfig;

  /// develop
  static final EnvConfig _developCfg = EnvConfig(
    appTitle: 'Develop',
    // baseUrl: 'http://10.245.1.42:9081',
    baseUrl: 'https://jsonplaceholder.typicode.com',
    webviewUrl: 'http://10.245.1.51',
  );

  /// test
  static final EnvConfig _testCfg = EnvConfig(
    appTitle: 'Test',
    baseUrl: 'http://10.245.1.52:9081',
    webviewUrl: 'http://10.245.1.51',
  );

  /// release
  static final EnvConfig _releaseCfg = EnvConfig(
    appTitle: 'Release',
    baseUrl: 'https://jwzl.gemdale-ly.com',
    webviewUrl: 'https://jwzl.gemdale-ly.com',
  );

  /// demo
  static final EnvConfig _demoCfg = EnvConfig(
    appTitle: 'Demo',
    baseUrl: 'http://show-space.gemdale-ly.com:9081',
    webviewUrl: 'http://show-space.gemdale-ly.com:10010',
  );

  /// Exhibition
  static final EnvConfig _exhibitionCfg = EnvConfig(
    appTitle: 'Exhibition ',
    baseUrl: 'http://116.28.65.100:9081',
    webviewUrl: 'http://10.245.9.30:10081',
  );
}
