import 'package:dio/dio.dart';
import 'core/parser/home_page_parser.dart';
import 'core/parser/post_content_parser.dart';
import 'core/parser/post_parser.dart';
import 'core/parser/search_results_parser.dart';
import 'core/model/post_content.dart';
import 'core/model/home_page.dart';
import 'core/model/post.dart';
import 'core/model/search_result.dart';

class SpaceTodayApi {
  final Dio dioClient;

  SpaceTodayApi(this.dioClient);

  Future<HomePage> getHomePage() async {
    final response = await this.dioClient.get(
          SpaceTodayPath.basePath,
        );
    return HomePageParser(PostParser()).parse(response.data);
  }

  Future<List<Post>> getCategoryPosts(final String url, {int page = 1}) async {
    if (page < 0) page = 1;
    final _url = _formatToPage(url, page);
    final response = await this.dioClient.get(_url);
    return PostParser().parse(response.data);
  }

  Future<List<SearchResult>> search(final String search) async {
    final url = SpaceTodayPath.basePath + "?s=${_formatSearchQuery(search)}";
    final response = await this.dioClient.get(
          url,
        );

    SearchResultsParser parser = SearchResultsParser();
    return parser.parse(response.data);
  }

  Future<PostContent> getPostContent(final String contentUrl) async {
    final response = await this.dioClient.get(contentUrl);
    return PostContentParser().parse(response.data);
  }

  String _formatSearchQuery(final String search) {
    if (search == null) return "";
    return search.replaceAll(' ', '+');
  }

  String _formatToPage(final String url, int page) => url + "page/$page/";
}

class SpaceTodayPath {
  static const basePath = "https://spacetoday.com.br/";
}
