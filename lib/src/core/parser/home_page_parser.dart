import 'package:spacetoday_crawler/src/core/model/exception.dart';
import 'package:spacetoday_crawler/src/core/model/home_page.dart';
import 'package:spacetoday_crawler/src/core/parser/IHtmlParser.dart';

import 'package:html/parser.dart' as htmlParser show parse;

class HomePageParser implements IHtmlParser<HomePage> {
  @override
  HomePage parse(String html) {
    try {
      final document = htmlParser.parse(html);
    } catch (_) {
      throw ParserException(
          message: "HomePageParser::parse wasn't possible parse home page");
    }
  }
}
