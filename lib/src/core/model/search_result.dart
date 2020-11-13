import 'package:spacetoday_crawler/src/core/model/category.dart';

import './abstract_post.dart';

class SearchResult extends AbstractPost {
  final String resume;

  SearchResult(
      {String contentUrl,
      String imageUrl,
      String title,
      Category category,
      this.resume})
      : super(
            category: category,
            contentUrl: contentUrl,
            imageUrl: imageUrl,
            title: title);
  @override
  String toString() =>
      'Title: $title\nCategory: $category\nUrl: $contentUrl\nImageUrl: $imageUrl\nResume: $resume';
}
