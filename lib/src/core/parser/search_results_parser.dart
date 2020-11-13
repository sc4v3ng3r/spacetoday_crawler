import 'package:html/dom.dart';
import 'package:spacetoday_crawler/src/core/model/category.dart';
import 'package:spacetoday_crawler/src/core/model/exception.dart';
import 'package:spacetoday_crawler/src/core/model/search_result.dart';
import 'package:spacetoday_crawler/src/core/parser/IHtmlParser.dart';
import 'package:html/parser.dart' as htmlParser show parse;

class SearchResultsParser implements IHtmlParser<List<SearchResult>> {
  @override
  List<SearchResult> parse(String html) {
    try {
      final document = htmlParser.parse(html);
      final wrapperDiv = document
          .getElementById('conteudo')
          .getElementsByClassName('wrapper')
          .first;

      final contentList = wrapperDiv.getElementsByTagName('h1')[2];
      return contentList.children.map((e) {
        try {
          return _extractResult(e);
        } catch (_) {}
      }).toList();
    } catch (_) {
      throw ParserException(
          message:
              "SearchResultsParser::parse wasn't possible parse search results.");
    }
  }

  SearchResult _extractResult(Element divPost) {
    final category =
        _extractCategory(divPost.getElementsByClassName('categoria').first);
    final imageDiv = divPost.getElementsByClassName('imagem-post').first;
    final imageUrl = _extractImageUrl(imageDiv);
    final title = _extractTitle(divPost.getElementsByClassName('titulo').first);
    final resume =
        _extractResume(divPost.getElementsByClassName('resumo').first);

    final contentUrl = _extractContentUrl(imageDiv);

    return SearchResult(
        category: category,
        contentUrl: contentUrl,
        imageUrl: imageUrl,
        resume: resume,
        title: title);
  }

  Category _extractCategory(Element categoryDiv) {
    try {
      final firstCategory = categoryDiv.getElementsByTagName('a').first;
      return Category(firstCategory.text, firstCategory.attributes['href']);
    } catch (_) {}
    return null;
  }

  String _extractImageUrl(Element imagePostDiv) {
    try {
      final img = imagePostDiv.getElementsByTagName('img').first;
      return img.attributes['src'];
    } catch (_) {}
    return null;
  }

  String _extractTitle(Element titleDiv) {
    try {
      final anchor = titleDiv.getElementsByTagName('a').first;
      return anchor.text;
    } catch (_) {}
    return "";
  }

  String _extractResume(Element resumeDiv) {
    try {
      final p = resumeDiv.getElementsByTagName('p').first;
      return p.text;
    } catch (_) {}
    return "";
  }

  String _extractContentUrl(Element imagePostDiv) {
    final anchor = imagePostDiv.getElementsByTagName('a').first;
    return anchor.attributes['href'];
  }
}
