import 'package:spacetoday_crawler/src/core/model/category.dart';

abstract class AbstractPost {
  String contentUrl;
  String imageUrl;
  String title;
  Category category;

  AbstractPost({
    this.contentUrl,
    this.imageUrl,
    this.title,
    this.category,
  });
}
