import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/src/model/user.dart' as data;
import 'package:data/src/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

const String COLLECTION_USER = 'user';

class UserFirebaseProvider implements UserProvider {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> hasId(String id) async {
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> result =
        (await _fireStore
                .collection(COLLECTION_USER)
                .where(FieldPath.documentId, isEqualTo: id)
                .limit(1)
                .get())
            .docs;

    return result.isNotEmpty;
  }

  @override
  Future<void> insert(String id, String fullName) async {
    final DocumentReference<Map<String, dynamic>> doc =
        _fireStore.collection(COLLECTION_USER).doc();

    await doc.set(<String, dynamic>{'id': id, 'full_name': fullName});
  }

  @override
  data.User? getCurrent() {
    final User? user = _firebaseAuth.currentUser;

    if (user == null) {
      return null;
    }

    return data.User(
      id: user.uid,
      fullName: user.displayName ?? 'Vasya',
    );
  }
}
