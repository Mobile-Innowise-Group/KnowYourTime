import 'package:data/src/model/activity.dart';

abstract class ActivityProvider {
  Stream<List<Activity>> observeAllByUserId(String userId);

}