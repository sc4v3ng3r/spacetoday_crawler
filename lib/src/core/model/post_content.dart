import './content_data.dart';

class PostContent {
  final String postImage;
  final String title;
  final String url;
  final List<ContentData> contents;

  PostContent({this.postImage, this.title, this.url, this.contents});
}
