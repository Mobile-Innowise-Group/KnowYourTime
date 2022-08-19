import 'package:domain/domain.dart';

abstract class UserRepository{
  Future<User> getCurrent();

  Future<bool> hasCurrent();
}