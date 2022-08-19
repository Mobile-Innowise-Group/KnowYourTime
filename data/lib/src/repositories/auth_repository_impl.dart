import 'package:data/data.dart';
import 'package:data/src/model/user.dart' as data;
import 'package:data/src/providers/user_provider.dart';
import 'package:domain/domain.dart' as domain;

class AuthRepositoryImpl extends domain.AuthRepository {
  final AuthProvider _authProvider;
  final UserProvider _userProvider;

  AuthRepositoryImpl({
    required AuthProvider authProvider,
    required UserProvider userProvider,
  })  : _authProvider = authProvider,
        _userProvider = userProvider;

  @override
  Future<domain.User?> signInWithEmailAndPassword(
      domain.EmailAndPassword params) async {
    final data.User? user = await _authProvider.signInWithEmailAndPassword(
      params.email,
      params.password,
    );

    if (user != null) {
      return domain.User(id: user.id, fullName: user.fullName);
    } else {
      return null;
    }
  }

  @override
  Future<void> signOut() {
    return _authProvider.signOut();
  }

  @override
  Future<domain.User?> signUpWithEmailAndPassword(
      domain.EmailAndPassword params) async {
    final data.User? user = await _authProvider.signUpWithEmailAndPassword(
      params.email,
      params.password,
    );
    if (user == null) {
      return null;
    } else {
      if (!(await _userProvider.hasId(user.id))) {
        await _userProvider.insert(user.id, user.fullName);
      }
      return domain.User(id: user.id, fullName: user.fullName);
    }
  }

  @override
  Future<domain.User?> signInWithSocial(domain.SignInSocialParam param) async {
    data.User? user;
    if (param is domain.GoogleSignIn) {
      user = await _authProvider.signInWithGoogle();
    } else if (param is domain.FacebookSignIn) {
      user = await _authProvider.signInWithFacebook();
    } else if (param is domain.AppleSignIn) {
      user = await _authProvider.signInWithApple();
    }
    if (user == null) {
      return null;
    } else {
      if (!(await _userProvider.hasId(user.id))) {
        await _userProvider.insert(user.id, user.fullName);
      }
      return domain.User(id: user.id, fullName: user.fullName);
    }
  }
}
