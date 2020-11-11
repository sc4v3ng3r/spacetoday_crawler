import '../model/content_data.dart';
import '../model/exception.dart';
import '../model/post_content.dart';
import '../parser/IHtmlParser.dart';

import 'package:html/parser.dart' as htmlParser show parse;
import 'package:html/dom.dart';

class PostContentParser implements IHtmlParser<PostContent> {
  @override
  PostContent parse(String html) {
    try {
      final document = htmlParser.parse(html);
      final contentPageDiv = document.getElementById('contentPage');
      final sidebarDiv =
          contentPageDiv.getElementsByClassName('sidebarPage').first;

      final headerImageUrl = _extractHeaderImageUrl(document);
      final postTitle = _extractTitle(document);
      final categoryName = _extractCategoryName(sidebarDiv);
      final categoryUrl = _extractCategoryUrl(sidebarDiv);
      final authorName = _extractAuthor(sidebarDiv);
      final date = _extractDate(sidebarDiv);

      final content = _extractPostContent(contentPageDiv);

      return PostContent(
        author: authorName,
        categoryName: categoryName,
        categoryUrl: categoryUrl,
        date: date,
        postHeaderImage: headerImageUrl,
        title: postTitle,
        contents: content,
      );
    } catch (_) {
      throw ParserException(
          message:
              "PostContentParser::parse Wasn't possible parse the content");
    }
  }

  List<ContentData> _extractPostContent(Element contentPageDiv) {
    final contentDiv = contentPageDiv.getElementsByClassName("content").first;
    final videoContentList = _extractVideoContent(contentDiv);

    final paragraphs = contentDiv.getElementsByTagName('p');

    final postContents = paragraphs.map((p) {
      if (p.children.isNotEmpty) {
        return _extractWithInternalContent(p);
      } else
        return ContentData(
          data: p.text.trim(),
          type: ContentType.TEXT,
        );
    }).toList();
    return []..addAll(videoContentList)..addAll(postContents);
  }

  List<ContentData> _extractVideoContent(Element contentDiv) {
    try {
      final iFrameList = contentDiv.getElementsByTagName('iframe');
      return iFrameList.map((iframe) {
        return ContentData(
          type: ContentType.VIDEO,
          data: iframe.attributes['src'],
        );
      }).toList();
    } catch (_) {}

    return [];
  }

  ContentData _extractWithInternalContent(Element element) {
    ContentData data;
    element.children.forEach((e) {
      switch (e.localName) {
        case 'a':
          data = ContentData(
              data: e.attributes['href'].trim(), type: ContentType.LINK);
          break;
        case 'span':
          data = ContentData(
              data: element.text + e.text.trim(), type: ContentType.TEXT);
          break;

        case 'img':
          data =
              ContentData(data: e.attributes['src'], type: ContentType.IMAGE);
          break;
        default:
          data = ContentData(data: element.text.trim(), type: ContentType.TEXT);
          break;
      }
    });

    return data;
  }

  String _extractHeaderImageUrl(Document document) {
    String imageUrl;
    try {
      final imageDiv = document.getElementById('imagemPage');
      final img = imageDiv.getElementsByTagName('img').first;
      imageUrl = img.attributes["src"];
    } catch (_) {}

    return imageUrl;
  }

  String _extractTitle(Document document) {
    try {
      final titleHeader = document.getElementById('titlePage');
      return titleHeader.text;
    } catch (_) {
      throw ParserException(
          message:
              "PostContentParser::parse wasn't possible extract the article title");
    }
  }

  String _extractCategoryName(Element sidebar) {
    try {
      final anchor = _extractCategoryAnchor(sidebar);
      return anchor.text;
    } catch (_) {}
    return "";
  }

  String _extractCategoryUrl(Element sidebar) {
    final anchor = _extractCategoryAnchor(sidebar);
    return anchor.attributes["href"];
  }

  Element _extractCategoryAnchor(Element sidebar) {
    final categoryElement =
        sidebar.getElementsByClassName('categorySidebar').first;
    return categoryElement.getElementsByTagName('a').first;
  }

  String _extractAuthor(Element sidebar) {
    try {
      return sidebar.getElementsByClassName('authorSidebar').first.text;
    } catch (_) {}
    return "";
  }

  String _extractDate(Element sidebar) {
    try {
      return sidebar.getElementsByClassName('dateSidebar').first.text;
    } catch (_) {}
    return "";
  }
}
