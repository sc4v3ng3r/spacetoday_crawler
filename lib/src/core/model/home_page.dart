import './most_readed_data.dart';
import './post.dart';

class HomePage {
  final List<String> categories;
  final List<MostReadedData> mostReaded;
  final List<Post> posts;

  HomePage({this.categories, this.mostReaded, this.posts});
}
