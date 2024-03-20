class User {
  static String name = "user";
  static int credits = 0;

  static final User _singleton = User._internal();
  User._internal();
  factory User() {
    return _singleton;
  }
}
