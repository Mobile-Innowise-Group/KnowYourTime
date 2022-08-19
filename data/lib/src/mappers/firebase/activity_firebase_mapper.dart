import 'package:data/src/model/activity.dart' as data;

const String FIELD_CATEGORY_ID = 'category_id';
const String FIELD_CREATED_AT = 'created_at';
const String FIELD_DURATION_IN_HOURS = 'duration_in_hours';
const String FIELD_USER_ID = 'user_id';

const String COLLECTION_ACTIVITY = 'activity';

class ActivityFirebaseToDataMapper {
  static data.Activity fromMap({
    required Map<String, dynamic> map,
    required String id,
  }) {

    if (<String>{
      FIELD_CREATED_AT,
      FIELD_CATEGORY_ID,
      FIELD_DURATION_IN_HOURS,
      FIELD_USER_ID
    }.every((String field) => map.keys.contains(field))) {
      return data.Activity(
        category_id: map[FIELD_CATEGORY_ID] as String,
        created_at:
            DateTime.fromMillisecondsSinceEpoch(map[FIELD_CREATED_AT] as int),
        duration: Duration(hours: map[FIELD_DURATION_IN_HOURS] as int),
        user_id: map[FIELD_USER_ID] as String,
        id: id,
      );
    } else {
      throw Exception('Missing keys (${<String>{
        FIELD_CREATED_AT,
        FIELD_CATEGORY_ID,
        FIELD_DURATION_IN_HOURS,
        FIELD_USER_ID
      }.difference(map.keys.toSet())}) while mapping');
    }
  }
}

extension ActivityDataToFirebase on data.Activity {
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      FIELD_CATEGORY_ID: category_id,
      FIELD_CREATED_AT: created_at.millisecondsSinceEpoch,
      FIELD_DURATION_IN_HOURS: duration.inHours,
      FIELD_USER_ID: user_id
    };
  }
}
