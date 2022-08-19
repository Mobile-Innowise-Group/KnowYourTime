import 'dart:async';

import 'package:data/src/model/activity.dart' as data;
import 'package:data/src/model/category.dart';
import 'package:data/src/providers/activity_provider.dart';
import 'package:data/src/providers/category_provider.dart';
import 'package:data/src/providers/user_provider.dart';
import 'package:domain/domain.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityProvider activityProvider;
  final CategoryProvider categoryProvider;
  final UserProvider userProvider;

  ActivityRepositoryImpl({
    required this.activityProvider,
    required this.categoryProvider,
    required this.userProvider,
  });

  @override
  Stream<Future<List<Activity>>> observeAll() {
    return activityProvider
        .observeAllByUserId((userProvider.getCurrent())!.id)
        .map((List<data.Activity> dataActivityList) async {
      final List<String> categoryIds = dataActivityList
          .map((data.Activity activity) => activity.category_id)
          .toSet()
          .toList();
      final List<Category> categories = (await Future.wait(categoryIds.map(
              (String categoryId) => categoryProvider.getById(categoryId))))
          .whereType<Category>()
          .toList();
      //data to domain
      return dataActivityList
          .where((data.Activity activity) => categories
              .map((Category cat) => cat.id)
              .contains(activity.category_id))
          .map((data.Activity activity) => Activity(
              categoryName: categories
                  .firstWhere(
                      (Category element) => element.id == activity.category_id)
                  .name,
              createdAt: activity.created_at,
              duration: activity.duration))
          .toList();
    });
  }
}
