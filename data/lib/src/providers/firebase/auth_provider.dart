import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:data/src/mappers/firebase/auth_user_mapper.dart';
import 'package:data/src/model/user.dart' as data;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthProvider {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<data.User?> signInWithEmailAndPassword(
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
        return AuthUserAuthMapper.fromFirebase(user);
      } else {
        throw Exception('No user_inno');
      }
    } catch (e) {
      return null;
    }
  }

  Future<data.User?> signUpWithEmailAndPassword(
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
        return AuthUserAuthMapper.fromFirebase(user);
      } else {
        throw Exception('No user_inno');
      }
    } catch (e) {
      return null;
    }
  }

  Future<data.User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return AuthUserAuthMapper.fromFirebase(
        (await FirebaseAuth.instance.signInWithCredential(credential)).user!,
      );
    } catch (e) {
      return null;
    }
  }

  String generateNonce([int length = 32]) {
    const String charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final Random random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  String sha256ofString(String input) {
    final List<int> bytes = utf8.encode(input);
    final Digest digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<data.User?> signInWithApple() async {
    try {
      final String rawNonce = generateNonce();
      final String nonce = sha256ofString(rawNonce);

      final AuthorizationCredentialAppleID appleCredential =
          await SignInWithApple.getAppleIDCredential(
        scopes: <AppleIDAuthorizationScopes>[
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final OAuthCredential oauthCredential =
          OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      return AuthUserAuthMapper.fromFirebase(
          (await FirebaseAuth.instance.signInWithCredential(oauthCredential))
              .user!);
    } catch (_) {
      return null;
    }
  }

  Future<data.User?> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      final fbUser = (await FirebaseAuth.instance
              .signInWithCredential(facebookAuthCredential))
          .user!;

      return AuthUserAuthMapper.fromFirebase(fbUser);
    } catch (_) {
      return null;
    }
  }

  Future<void> signOut() async => await _fAuth.signOut();

  Stream<data.User?> get currentUser {
    return _fAuth.authStateChanges().map(
      (User? user) {
        return user != null ? AuthUserAuthMapper.fromFirebase(user) : null;
      },
    );
  }
}
