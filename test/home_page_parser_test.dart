import 'dart:math';

import 'package:spacetoday_crawler/src/core/model/exception.dart';
import 'package:spacetoday_crawler/src/core/model/home_page.dart';
import 'package:spacetoday_crawler/src/core/model/post.dart';
import 'package:spacetoday_crawler/src/core/parser/IHtmlParser.dart';
import 'package:spacetoday_crawler/src/core/parser/home_page_parser.dart';
import 'package:spacetoday_crawler/src/core/parser/post_parser.dart';
import 'package:test/test.dart';
import 'test_data/home_page_data.dart';

main() {
  IHtmlParser<HomePage> homePageParser;
  IHtmlParser<List<Post>> postsParser;

  setUp(() {
    postsParser = PostParser();
    homePageParser = HomePageParser(postsParser);
  });

  test('Testing HomePageParser success with HomePage data', () {
    final data = homePageParser.parse(homePage);

    expect(data != null, true);
    expect(data, isA<HomePage>());
    expect(data.categories.isNotEmpty, true);
    expect(data.mostReaded.isNotEmpty, true);
    expect(data.posts.isNotEmpty, true);
  });

  test('Testing HomePageParser failure throwing ParserException', () {
    expect(() => homePageParser.parse(null),
        throwsA(TypeMatcher<ParserException>()));
  });

  tearDown(() {
    homePageParser = null;
    postsParser = null;
  });
}
