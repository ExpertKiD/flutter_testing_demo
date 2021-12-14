class LoginService {
  Future<bool> loginWithUsernameAndPassword(
      String username, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    if (username == 'username' && password == 'password') {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
