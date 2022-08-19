import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/src/mappers/firebase/activity_firebase_mapper.dart';
import 'package:data/src/model/activity.dart';
import 'package:data/src/providers/activity_provider.dart';

class ActivityFirebaseProvider implements ActivityProvider {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Stream<List<Activity>> observeAllByUserId(String userId) {
    return _fireStore.collection(COLLECTION_ACTIVITY).snapshots().map(
      (QuerySnapshot<Map<String, dynamic>> event) {
        return event.docs
            .where(
              (QueryDocumentSnapshot<Map<String, dynamic>> doc) {
                final Map<String, dynamic> docMap = doc.data();

                final docUserId = docMap[FIELD_USER_ID];
                return docUserId == userId;
              },
            )
            .map(
              (QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
                  ActivityFirebaseToDataMapper.fromMap(
                map: doc.data(),
                id: doc.id,
              ),
            )
            .toList();
      },
    );
  }
}
