import 'package:domain/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserMapper {
  static UserInno fromFirebase(User user){
    return UserInno(id: user.uid);
  }
}