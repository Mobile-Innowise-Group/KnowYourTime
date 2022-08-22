import 'package:domain/domain.dart';

abstract class AuthRepository {
  Future<User?> signInWithEmailAndPassword(EmailAndPassword params);

  Future<void> signOut();

  Future<User?> signUpWithEmailAndPassword(EmailAndPassword params);

  Future<User?> signInWithSocial(SignInSocialParam param);
}

class EmailAndPassword {
  final String email;
  final String password;

  EmailAndPassword({
    required this.email,
    required this.password,
  });
}

class GoogleSignIn implements SignInSocialParam {}

class AppleSignIn implements SignInSocialParam {}

class FacebookSignIn implements SignInSocialParam {}

abstract class SignInSocialParam {}
