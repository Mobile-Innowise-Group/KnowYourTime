import 'package:data/src/model/user.dart' as data;

const String FIELD_USER_ID = 'user_id';
const String FIELD_FULL_NAME = 'full_name';

class UserFirebaseToDomainMapper {
  static data.User fromMap({
    required Map<String, dynamic> map,
  }) {
    return data.User(
      id: map[FIELD_USER_ID] as String,
      fullName: map[FIELD_FULL_NAME] as String,
    );
  }
}

extension UserDataToFirebase on data.User {
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      FIELD_USER_ID: id,
      FIELD_FULL_NAME: fullName,
    };
  }
}
