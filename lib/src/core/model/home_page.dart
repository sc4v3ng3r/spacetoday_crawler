import './category.dart';
import './most_readed_data.dart';
import './post.dart';

class HomePage {
  final List<Category> categories;
  final List<MostReadedData> mostReaded;
  final List<Post> posts;
  final List<Post> highlight;

  HomePage({this.categories, this.mostReaded, this.posts, this.highlight});
}
