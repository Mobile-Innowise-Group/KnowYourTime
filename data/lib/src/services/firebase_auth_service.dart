import 'package:data/src/mappers/user_mapper/user_mapper.dart';
import 'package:domain/src/entities/user/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<UserInno?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = result.user;
      if (user != null) {
        return UserMapper.fromFirebase(user);
      } else {
        throw Exception('No user');
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserInno?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential result = await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User? user = result.user;
      if (user != null) {
        return UserMapper.fromFirebase(user);
      } else {
        throw Exception('No user');
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    await _fAuth.signOut();
  }

  Stream<UserInno?> get currentUser {
    return _fAuth.authStateChanges().map(
        (User? user) => user != null ? UserMapper.fromFirebase(user) : null);
  }
}
