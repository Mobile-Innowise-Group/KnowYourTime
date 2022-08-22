import 'package:data/src/model/user.dart';

abstract class UserProvider {
  Future<bool> hasId(String id);

  Future<void> insert(String id, String fullName);

  User? getCurrent();
}
