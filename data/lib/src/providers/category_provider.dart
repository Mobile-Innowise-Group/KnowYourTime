import 'package:data/src/model/category.dart';

abstract class CategoryProvider {
  Future<Category?> getById(String id);
}
