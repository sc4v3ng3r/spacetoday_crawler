import './content_data.dart';

class PostContent {
  final String postImage;
  final String title;
  final String categoryName;
  final String categoryUrl;
  final String author;
  final String date;
  final List<ContentData> contents;

  PostContent(
      {this.postImage,
      this.title,
      this.categoryName,
      this.categoryUrl,
      this.author,
      this.date,
      this.contents});

  @override
  String toString() => '''
    Title: $title\n
    Author: $author\n
    Date: $date\n
    Category: $categoryName\n
    Category Url: $categoryUrl\n
    Content: $contents
   ''';
}
