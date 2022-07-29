import 'package:domain/src/entities/user/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserMapper {
  static UserInno fromFirebase(User user) => UserInno(id: user.uid);
}
