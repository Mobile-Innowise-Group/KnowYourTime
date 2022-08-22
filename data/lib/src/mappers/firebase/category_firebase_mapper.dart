import 'package:data/src/model/category.dart' as data;

const String FIELD_NAME = 'name';
const String FIELD_ID = 'id';

class CategoryFirebaseToDataMapper {
  static data.Category fromMap({
    required Map<String, dynamic> map,
  }) {
    return data.Category(
      name: map[FIELD_NAME] as String,
      id: map[FIELD_ID] as String,
    );
  }
}

extension CategoryDataToFirebase on data.Category {
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      FIELD_NAME: name,
      FIELD_ID: id,
    };
  }
}
