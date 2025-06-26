class ApiEndPoints{
  static const String baseUrl = 'http://25.7.206.166/grad/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();

}

class _AuthEndPoints {
  final String registerEmail = 'register.php';
  final String loginEmail = 'login.php';
}