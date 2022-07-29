import 'package:data/src/mappers/user_mapper/user_mapper.dart';
import 'package:domain/src/entities/user/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<UserInno?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final UserCredential result = await _fAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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

  Future<UserInno?> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final UserCredential result = await _fAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
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

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    await _fAuth.signOut();
  }

  Stream<UserInno?> get currentUser {
    return _fAuth.authStateChanges().map(
      (User? user) {
        return user != null ? UserMapper.fromFirebase(user) : null;
      },
    );
  }
}
