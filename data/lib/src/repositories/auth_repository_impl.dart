import 'package:data/src/services/firebase_auth_service.dart';
import 'package:domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl({
    required AuthService authService,
  }) : _authService = authService;

  @override
  Future<void> signInWithGoogle() async {
    await _authService.signInWithGoogle();
  }

  @override
  Future<UserInno?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _authService.signInWithEmailAndPassword(
      email,
      password,
    );
  }

  @override
  Future<void> signInWithFacebook() async {
    await _authService.signInWithFacebook();
  }

  @override
  Future<void> signInWithApple() async {
    await _authService.signInWithApple();
  }

  @override
  Future<UserInno?> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _authService.registerWithEmailAndPassword(
      email,
      password,
    );
  }
}
