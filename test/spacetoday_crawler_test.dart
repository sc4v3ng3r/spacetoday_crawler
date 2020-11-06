import 'package:spacetoday_crawler/src/core/model/post.dart';
import 'package:spacetoday_crawler/src/core/parser/IHtmlParser.dart';
import 'package:spacetoday_crawler/src/core/parser/post_parser.dart';
import 'package:test/test.dart';

import 'test_data/category_page_data.dart';
import 'test_data/empty_category_page_data.dart';
import 'test_data/home_page_data.dart';

void main() {
  PostParser parser;
  setUp(() {
    parser = PostParser();
  });

  test('Testing success PostParser with HomePage', () {
    List<Post> posts = parser.parse(homePage);

    expect(posts != null, true);
    expect(posts.isNotEmpty, true);
    expect(posts.length == 12, true);
  });

  test('Testing Success PostParser with CategoryPage', () {
    List<Post> posts = parser.parse(categoryPage);
    expect(posts != null, true);
    expect(posts.isNotEmpty, true);
    expect(posts.length == 9, true);
  });

  test('Testing with empty category page', () {
    List<Post> posts = parser.parse(emptyCategoryPage);
    print(posts);
    expect(posts.isEmpty, true);
  });
}
