import 'package:spacetoday_crawler/src/core/model/exception.dart';
import 'package:spacetoday_crawler/src/core/model/search_result.dart';
import 'package:spacetoday_crawler/src/core/parser/IHtmlParser.dart';
import 'package:spacetoday_crawler/src/core/parser/search_results_parser.dart';
import 'package:test/test.dart';

import 'test_data/search_data.dart';
import 'test_data/search_empty_data.dart';

main() {
  IHtmlParser<List<SearchResult>> parser;

  setUp(() {
    parser = SearchResultsParser();
  });

  tearDown(() => parser = null);

  test('Testing SearchResultsParser success with a valid search', () {
    final data = parser.parse(searchData);
    expect(data.isNotEmpty, true);
    expect(data, isA<List<SearchResult>>());
  });

  test('Testing SearchResultsParser success with an empty search results', () {
    final data = parser.parse(searchEmptyData);
    expect(data.isEmpty, true);
    expect(data, isA<List<SearchResult>>());
  });

  test('Testing SearchResultsParser failure throwing ParserExpcetion', () {
    expect(() => parser.parse(null), throwsA(TypeMatcher<ParserException>()));
  });
}
