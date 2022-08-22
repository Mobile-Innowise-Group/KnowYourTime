import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/src/model/category.dart';

import 'package:data/src/providers/category_provider.dart';

const String COLLECTION_CATEGORY = 'category';

class CategoryFirebaseProvider implements CategoryProvider {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Future<Category?> getById(String id) async {
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> result =
        (await _fireStore
                .collection(COLLECTION_CATEGORY)
                .where(FieldPath.documentId, isEqualTo: id)
                .limit(1)
                .get())
            .docs;

    if (result.isNotEmpty) {
      return Category(name: result.first.data()['name'] as String, id: id);
    } else {
      return null;
    }
  }
}
