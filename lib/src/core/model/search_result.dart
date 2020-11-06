import './abstract_post.dart';

class SearchResult extends AbstractPost {
  final String resume;

  SearchResult(
      {String contentUrl,
      String imageUrl,
      String title,
      String categoryName,
      this.resume})
      : super(
            categoryName: categoryName,
            contentUrl: contentUrl,
            imageUrl: imageUrl,
            title: title);
  @override
  String toString() =>
      'Title: $title\nCategory: $categoryName\nUrl: $contentUrl\nImageUrl: $imageUrl\nResume: $resume';
}
