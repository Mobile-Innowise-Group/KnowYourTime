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
        .map(
      (List<data.Activity> dataActivityList) async {
        final List<String> categoryIds = dataActivityList
            .map((data.Activity activity) => activity.categoryId)
            .toSet()
            .toList();
        final List<Category> categories = (await Future.wait(
          categoryIds.map(
            (String categoryId) => categoryProvider.getById(categoryId),
          ),
        ))
            .whereType<Category>()
            .toList();
        //data to domain
        return dataActivityList
            .where((data.Activity activity) => categories
                .map((Category cat) => cat.id)
                .contains(activity.categoryId))
            .map((data.Activity activity) => Activity(
                categoryName: categories
                    .firstWhere(
                        (Category element) => element.id == activity.categoryId)
                    .name,
                createdAt: activity.createdAt,
                duration: activity.duration))
            .toList();
      },
    );
  }
}
