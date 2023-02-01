import 'package:test/test.dart';
import 'package:xdnotes/services/auth/auth_exceptions.dart';
import 'package:xdnotes/services/auth/auth_provider.dart';
import 'package:xdnotes/services/auth/auth_user.dart';

class NotInitializedException implements Exception {}

void main() {
  group("Mock auth", () {
    final provider = MockAuthProvider();
    test("test1", () {
      expect(provider.isInitialized, false);
    });
    test("test2", () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitializedException>()),
      );
    });
    test("test3", () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });
    test("test4", () {
      expect(provider.currentUser, null);
    });
    test("test5", () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    }, timeout: const Timeout(Duration(seconds: 2)));
    test("create user", () async {
      final email = provider.createUser(
        email: "rwser@fsd.com",
        password: "asdf",
      );
      expect(email, throwsA(const TypeMatcher<UserNotFoundAuthException>()));

      final bPassword = provider.createUser(email: "sdf", password: "sdff");
      expect(
          bPassword, throwsA(const TypeMatcher<WrongPasswordAuthException>()));

      final user = await provider.createUser(email: "wer", password: "sdfsdf");
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });

    test(
      'login verify',
      () {
        provider.sendEmailVerification();
        final user = provider.currentUser;
        expect(user, isNotNull);
        expect(user!.isEmailVerified, true);
      },
    );

    test('logout login again', () async {
      await provider.logOut();
      await provider.logIn(
        email: 'sdf',
        password: 'sdfs',
      );
      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

class MockAuthProvider implements AuthProvider {
  var _isInitialized = false;
  AuthUser? _user;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException;
    await Future.delayed(const Duration(seconds: 1));
    return logIn(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) {
    if (!isInitialized) throw NotInitializedException;
    if (email == "sdf@sdf.com") throw UserNotFoundAuthException();
    if (password == "fsdf2") throw WeakPasswordAuthException();
    const user = AuthUser(isEmailVerified: false);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException;
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException;
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(isEmailVerified: true);
    _user = newUser;
  }
}
