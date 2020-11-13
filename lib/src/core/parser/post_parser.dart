import 'package:spacetoday_crawler/src/core/model/category.dart';
import 'package:spacetoday_crawler/src/core/model/exception.dart';
import '../model/post.dart';
import 'IHtmlParser.dart';
import 'package:html/parser.dart' as htmlParser show parse;
import 'package:html/dom.dart';

/// This class is reposible for hanle a html page with posts
/// and extract all the posts from that page.
/// Pages like home page and category page should use this class
/// to parse the posts.
class PostParser implements IHtmlParser<List<Post>> {
  String latestPostTitle;

  @override
  List<Post> parse(String html) {
    try {
      final document = htmlParser.parse(
        html,
      );
      final loopBlog = document.getElementById('loopBlog');
      return _postsExtractor(loopBlog);
    } catch (_) {
      throw ParserException(
          message: "PostParser::parse Wasn't parse this post");
    }
  }

  List<Post> _postsExtractor(final Element loopBlogElement) {
    final articles = loopBlogElement?.getElementsByTagName('article');
    List<Post> postsData = [];

    articles.forEach((element) {
      try {
        var post = _postExtractor(element);
        if (post != null) postsData.add(post);
      } catch (_) {}
    });
    return postsData;
  }

  Post _postExtractor(Element element) {
    // getting post title
    final title = _extractTitle(element);

    if (title == this.latestPostTitle)
      throw "Duplicated Content";
    else
      this.latestPostTitle = title;
    // getting post category name
    final category = _extractCategory(element);

    // getting post url
    final contentUrl = _extractPostContentUrl(element);

    // getting post Image url
    final imageUrl = _extractImageUrl(element);

    // getting post author
    final author = _extractAuthor(element);

    return Post(
      author: author,
      category: category,
      imageUrl: imageUrl,
      contentUrl: contentUrl,
      title: title,
    );
  }

  Category _extractCategory(Element element) {
    try {
      final categoryAnchor = element
          ?.getElementsByTagName('ul')
          ?.first
          ?.getElementsByTagName('li')
          ?.first
          ?.getElementsByTagName('a')
          ?.first;
      return Category(categoryAnchor?.text, categoryAnchor.attributes['href']);
    } catch (_) {
      // print("PostParser::_extractCategoryName couldn't find category name");
    }
    return null;
  }

  String _extractImageUrl(Element element) {
    try {
      final thumbAnchor = element
          ?.getElementsByClassName("thumb")
          ?.first
          ?.getElementsByTagName('a')
          ?.first;
      final img = thumbAnchor?.getElementsByTagName('img')?.first;
      return img?.attributes["src"] ?? null;
    } catch (ex) {
      // print("PostParser::_extractImageUrl couldn't find image url");
    }

    return null;
  }

  String _extractTitle(Element element) {
    try {
      final titleAnchor = element
          ?.getElementsByClassName('conteudoPost')
          ?.first
          ?.getElementsByTagName('a')
          ?.first;
      return titleAnchor?.text ?? "";
    } catch (ex) {
      throw ParserException(
          message: "PostParser::_extractTitle couldn't find title");
    }
  }

  String _extractAuthor(Element element) {
    try {
      return element
          ?.getElementsByClassName("authorPost")
          ?.first
          ?.getElementsByTagName('p')
          ?.first
          ?.text;
    } catch (ex) {
      // print("PostParser::_extractAuthor couldn't find author");
    }
    return "";
  }

  String _extractPostContentUrl(Element element) {
    try {
      return element
          ?.getElementsByClassName("conteudoPost")
          ?.first
          ?.getElementsByTagName('a')
          ?.first
          ?.attributes["href"];
    } catch (ex) {
      throw ParserException(
          message:
              "PostParser::_extractPostContentUrl couldn't find content url");
    }
  }
// <div class="categoryPost" id="space-today-tv">
//  <ul class="post-categories">
//    <li><a href="https://spacetoday.com.br/category/space-today-tv/" rel="category tag">Space Today TV</a></li></ul>
// </div>
//
//  <div class="thumb">
//    <a href="https://spacetoday.com.br/atualizacoes-da-osiris-rex-guardando-as-amostras-do-asteroide-bennu-ao-vivo/"><img width="301" height="316" src="https://spacetoday.com.br/wp-content/uploads/2020/10/D4FUalrTkgU-301x316.jpg" class="attachment-homethumbs size-homethumbs wp-post-image" alt="" loading="lazy"></a>
//  </div>
//
//  <div class="conteudoPost">
//    <h1>
//      <a href="https://spacetoday.com.br/atualizacoes-da-osiris-rex-guardando-as-amostras-do-asteroide-bennu-ao-vivo/">ATUALIZAÇÕES DA OSIRIS-REX – GUARDANDO AS AMOSTRAS DO ASTEROIDE BENNU | AO VIVO</a>
//    </h1>
//  </div>
//
//  <div class="authorPost">
//    <p>Por: Space Today</p>
//  <div>

}
