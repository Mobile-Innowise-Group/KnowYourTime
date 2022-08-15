import 'package:domain/domain.dart';

abstract class AuthRepository {
  Future<void> signInWithGoogle();

  Future<UserInno?> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signInWithFacebook();

  Future<void> signInWithApple();

  Future<UserInno?> registerWithEmailAndPassword({
    required String email,
    required String password,
  });
}
