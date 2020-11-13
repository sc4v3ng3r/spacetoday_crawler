import './abstract_post.dart';
import 'category.dart';

class Post extends AbstractPost {
  final String author;
  Post(
      {String contentUrl,
      String imageUrl,
      String title,
      Category category,
      this.author})
      : super(
          contentUrl: contentUrl,
          imageUrl: imageUrl,
          title: title,
          category: category,
        );

  @override
  String toString() =>
      'Title: $title\nCategory: $category\nAuthor: $author\nUrl: $contentUrl\nImageUrl: $imageUrl';
}
