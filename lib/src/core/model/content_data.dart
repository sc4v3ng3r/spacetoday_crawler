enum ContentType { TEXT, VIDEO, IMAGE }

class ContentData {
  final ContentType type;
  final String data;

  ContentData({this.type, this.data});
}
