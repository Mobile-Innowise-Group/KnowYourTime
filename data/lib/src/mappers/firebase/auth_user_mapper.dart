import 'package:data/src/model/user.dart' as data;
import 'package:firebase_auth/firebase_auth.dart';

class AuthUserMapper {
  static data.User fromFirebase(User user) {
    return data.User(id: user.uid, fullName: user.displayName ?? 'Sanya');
  }
}
