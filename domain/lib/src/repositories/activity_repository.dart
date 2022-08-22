import 'package:domain/domain.dart';

abstract class ActivityRepository {
  Stream<Future<List<Activity>>> observeAll();
}
