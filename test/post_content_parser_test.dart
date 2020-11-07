import 'package:spacetoday_crawler/src/core/model/exception.dart';
import 'package:spacetoday_crawler/src/core/model/post_content.dart';
import 'package:spacetoday_crawler/src/core/parser/IHtmlParser.dart';
import 'package:spacetoday_crawler/src/core/parser/post_content_parser.dart';
import 'package:test/test.dart';

import 'test_data/content_page_with_images_data.dart';
import 'test_data/content_page_with_video_data.dart';

main() {
  IHtmlParser parser;

  setUp(() {
    parser = PostContentParser();
  });

  tearDown(() => parser = null);

  test("Testing PostContentParser success in page content with video", () {
    final data = parser.parse(contentPageWithVideo);
    expect(data, isA<PostContent>());
  });

  test("Testing PostContentParser success in page content with images", () {
    final data = parser.parse(contentPageWithImages);
    expect(data, isA<PostContent>());
  });

  test("Testing PostContentParser failure throwing ParserException", () {
    expect(() => parser.parse(null), throwsA(TypeMatcher<ParserException>()));
  });
}
