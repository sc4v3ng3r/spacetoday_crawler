import '../model/category.dart';
import '../model/exception.dart';
import '../model/home_page.dart';
import '../model/most_readed_data.dart';
import '../model/post.dart';
import './IHtmlParser.dart';

import 'package:html/dom.dart';
import 'package:html/parser.dart' as htmlParser show parse;

class HomePageParser implements IHtmlParser<HomePage> {
  final IHtmlParser<List<Post>> postsParser;

  HomePageParser(this.postsParser);

  @override
  HomePage parse(String html) {
    try {
      final document = htmlParser.parse(html);

      final categories = _extractCategories(document);
      final highlightImages =
          _extractHighlightImages(document.getElementById('slideshow_1'));

      final posts = this.postsParser.parse(html);
      final mostViewed = _extractMostReaded(document);

      return HomePage(
        categories: categories,
        posts: posts,
        mostReaded: mostViewed,
        highlight: _generateHighlightPosts(posts, highlightImages),
      );
    } catch (_) {
      throw ParserException(
          message: "HomePageParser::parse wasn't possible parse home page");
    }
  }

  List<Post> _generateHighlightPosts(
      List<Post> allPosts, List<String> highlightImages) {
    try {
      return List.generate(highlightImages.length, (index) {
        final post = allPosts[index];
        final image = highlightImages[index];

        if (image != null || image.isNotEmpty) post.imageUrl = image;
        return post;
      });
    } catch (_) {}
    return [];
  }

  List<String> _extractHighlightImages(Element slideElement) {
    final imageList = <String>[];
    try {
      final images = slideElement.getElementsByTagName('img');
      String previousImage;
      images.forEach((e) {
        var currentImage = e.attributes['src'];
        if (currentImage != previousImage) {
          imageList.add(currentImage);
          previousImage = currentImage;
        }
      });
      // return images.map((e) => e.attributes['src']).toList();
    } catch (_) {}

    return imageList;
  }

  List<MostReadedData> _extractMostReaded(Document document) {
    try {
      final anchorList = document.getElementsByClassName("wpp-post-title");
      return anchorList.map((e) {
        return MostReadedData(
          title: e.attributes['title'],
          url: e.attributes['href'],
        );
      }).toList();
    } catch (_) {}
    return [];
  }

  List<Category> _extractCategories(Document document) {
    try {
      final categoryElements = document
          .getElementById('cssmenu')
          .getElementsByTagName('ul')
          .first
          .getElementsByClassName('menu-item-object-category');
      return categoryElements.map((e) {
        final categoryAnchor = e.getElementsByTagName('a').first;
        return Category(categoryAnchor.text, categoryAnchor.attributes['href']);
      }).toList();
    } catch (_) {}
    return [];
  }
}
