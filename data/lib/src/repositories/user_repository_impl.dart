import 'package:data/src/model/user.dart' as data;
import 'package:data/src/providers/user_provider.dart';
import 'package:domain/domain.dart' as domain;

class UserRepositoryImpl implements domain.UserRepository {
  final UserProvider _userProvider;

  UserRepositoryImpl({
    required UserProvider userProvider,
  }) : _userProvider = userProvider;

  @override
  Future<domain.User> getCurrent() async => _getCurrent()!;

  @override
  Future<bool> hasCurrent() async => _getCurrent() != null;

  domain.User? _getCurrent() {
    final data.User? user = _userProvider.getCurrent();

    if (user == null) {
      return null;
    }

    return domain.User(id: user.id, fullName: user.fullName);
  }

}
