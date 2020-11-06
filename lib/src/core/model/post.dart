import './abstract_post.dart';

class Post extends AbstractPost {
  final String author;
  Post(
      {String contentUrl,
      String imageUrl,
      String title,
      String categoryName,
      this.author})
      : super(
          contentUrl: contentUrl,
          imageUrl: imageUrl,
          title: title,
          categoryName: categoryName,
        );

  @override
  String toString() =>
      'Title: $title\nCategory: $categoryName\nAuthor: $author\nUrl: $contentUrl\nImageUrl: $imageUrl';
}
