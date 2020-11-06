enum ContentType { TEXT, VIDEO, IMAGE, LINK }

class ContentData {
  final ContentType type;
  final String data;

  ContentData({this.type, this.data});

  @override
  String toString() => "\nType: $type\nData: $data";
}
