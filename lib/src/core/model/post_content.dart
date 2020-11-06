import './content_data.dart';

class PostContent {
  final String postHeaderImage;
  final String title;
  final String categoryName;
  final String categoryUrl;
  final String author;
  final String date;
  final List<ContentData> contents;

  PostContent(
      {this.postHeaderImage,
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
