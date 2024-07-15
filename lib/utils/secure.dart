class Secure {
  static Secure? _instance;
  factory Secure() => _instance ??= Secure._internal();
  Secure._internal() {}
}
