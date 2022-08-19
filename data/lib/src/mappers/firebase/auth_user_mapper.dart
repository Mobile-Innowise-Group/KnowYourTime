import 'package:data/src/model/user.dart' as data;
import 'package:firebase_auth/firebase_auth.dart';

class AuthUserAuthMapper {
  static data.User fromFirebase(User user) =>
      data.User(id: user.uid, fullName: user.displayName ?? 'Vasya');
}
