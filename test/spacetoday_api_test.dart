import 'package:dio/dio.dart';
import 'package:spacetoday_crawler/src/core/model/exception.dart';
import 'package:spacetoday_crawler/src/core/model/home_page.dart';
import 'package:spacetoday_crawler/src/core/model/post_content.dart';
import 'package:spacetoday_crawler/src/spacetoday_api.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'test_data/category_page_data.dart';
import 'test_data/content_page_with_images_data.dart';
import 'test_data/content_page_with_video_data.dart';
import 'test_data/empty_category_page_data.dart';
import 'test_data/home_page_data.dart';
import 'test_data/search_data.dart';
import 'test_data/search_empty_data.dart';

class MockedClient extends Mock with Dio {}

main() {
  SpaceTodayApi api;
  MockedClient client;

  setUp(() {
    client = MockedClient();
    api = SpaceTodayApi(client);
  });

  tearDown(() {
    api = null;
    client = null;
  });

  group('getHomePage method tests group', () {
    Response responseWithSuccess;
    setUp(() {
      responseWithSuccess = Response(data: homePage);
    });
    tearDown(() {
      responseWithSuccess = null;
    });
    test('Testing api.getHomePage() success with HomePage data', () async {
      when(client.get(
        SpaceTodayPath.basePath,
      )).thenAnswer((_) async => responseWithSuccess);

      final data = await api.getHomePage();
      expect(data, isA<HomePage>());
      expect(data.posts.isNotEmpty, true);
      expect(data.categories.isNotEmpty, true);
      expect(data.mostReaded.isNotEmpty, true);
    });

    test('Testing api.getHomePage() failure throwing DioError', () async {
      when(client.get<String>(
        SpaceTodayPath.basePath,
      )).thenThrow(DioError());
      expect(() => api.getHomePage(), throwsA(TypeMatcher<DioError>()));
    });

    test('Testing api.getHomePage() failure throwing ParserException',
        () async {
      final response = Response(data: null);
      when(client.get<String>(
        SpaceTodayPath.basePath,
      )).thenAnswer((_) async => response);

      expect(() => api.getHomePage(), throwsA(TypeMatcher<ParserException>()));
    });
  });

  group('search method method tests group', () {
    String searchPath;
    String searchQuery;
    String emptySearchPath;
    String emptySearchQuery;
    Response searchSuccessResponse, searchFailureResponse, searchEmptyResponse;

    setUp(() {
      searchQuery = "marte";
      searchPath = "https://spacetoday.com.br/?s=$searchQuery";
      searchSuccessResponse = Response(data: searchData);
      searchFailureResponse = Response(data: null);
      searchEmptyResponse = Response(data: searchEmptyData);
      emptySearchQuery = "puxpux";
      emptySearchPath = "https://spacetoday.com.br/?s=$emptySearchQuery";
    });

    tearDown(() {
      searchQuery = null;
      searchPath = null;
      searchSuccessResponse = null;
      searchFailureResponse = null;
      searchEmptyResponse = null;
      emptySearchQuery = null;
      emptySearchPath = null;
    });

    test('Testing api.search() mehtod success', () async {
      when(client.get(
        searchPath,
      )).thenAnswer((_) async => searchSuccessResponse);

      final searchResults = await api.search(searchQuery);
      expect(searchResults.isNotEmpty, true);
    });

    test('Testing api.search() mehtod success with empty results', () async {
      when(client.get(emptySearchPath))
          .thenAnswer((_) async => searchEmptyResponse);

      final searchResults = await api.search(emptySearchQuery);
      expect(searchResults.isEmpty, true);
    });

    test('Testing api.search() mehtod failure throwing DioError', () async {
      when(client.get(searchPath)).thenThrow(DioError());
      expect(() => api.search(searchQuery), throwsA(TypeMatcher<DioError>()));
    });

    test('Testing api.search() mehtod failure throwing ParserException',
        () async {
      when(client.get(searchPath))
          .thenAnswer((_) async => searchFailureResponse);
      expect(() => api.search(searchQuery),
          throwsA(TypeMatcher<ParserException>()));
    });
  });

  group('getPostContent method test group', () {
    Response videoSuccessfullyResponse,
        imageSuccessfullyResponse,
        noDataResponse;
    String contentVideo, contentImage;

    setUp(() {
      videoSuccessfullyResponse = Response(data: contentPageWithVideo);
      imageSuccessfullyResponse = Response(data: contentPageWithImages);
      noDataResponse = Response(data: null);

      contentVideo = 'contentVideo';
      contentImage = 'contentImage';
    });

    tearDown(() {
      noDataResponse =
          videoSuccessfullyResponse = imageSuccessfullyResponse = null;
      contentImage = contentVideo = null;
    });

    test('Testing api.getPostContent success with video content', () async {
      when(client.get(contentVideo))
          .thenAnswer((realInvocation) async => videoSuccessfullyResponse);

      final data = await api.getPostContent(contentVideo);
      expect(data, isA<PostContent>());
      expect(data.title != null, true);
    });

    test('Testing getPostContent success with image content', () async {
      when(client.get(contentImage))
          .thenAnswer((realInvocation) async => imageSuccessfullyResponse);

      final data = await api.getPostContent(contentImage);
      expect(data, isA<PostContent>());
      expect(data.title != null, true);
    });

    test('Testing getPostContent failure throwing DioError', () async {
      when(client.get(contentImage)).thenThrow(DioError());
      expect(
          api.getPostContent(contentImage), throwsA(TypeMatcher<DioError>()));
    });

    test('Testing getPostContent failure throwing ParserException', () async {
      when(client.get(contentImage))
          .thenAnswer((realInvocation) async => noDataResponse);
      expect(api.getPostContent(contentImage),
          throwsA(TypeMatcher<ParserException>()));
    });
  });

  group('getCategoryPosts method test group', () {
    Response successReponse, noDataResponse, emptyDataResponse;
    String categoryUrl =
        "https://spacetoday.com.br/category/categoryUrl/page/1/";
    setUp(() {
      successReponse = Response(data: categoryPage);
      emptyDataResponse = Response(data: emptyCategoryPage);
      noDataResponse = Response(data: null);
    });

    tearDown(() {
      successReponse = emptyDataResponse = noDataResponse = null;
    });

    test('Testing getCategoryPosts success with data', () async {
      when(client.get(categoryUrl))
          .thenAnswer((realInvocation) async => successReponse);
      final data = await api.getCategoryPosts(
          "https://spacetoday.com.br/category/categoryUrl/",
          page: 1);

      expect(data.isNotEmpty, true);
    });

    test('Testing getCategoryPosts success with empty data', () async {
      when(client.get(categoryUrl))
          .thenAnswer((realInvocation) async => emptyDataResponse);
      final data = await api.getCategoryPosts(
          "https://spacetoday.com.br/category/categoryUrl/",
          page: 1);

      expect(data.isEmpty, true);
    });

    test('Testing getCategoryPosts failure with DioError', () {
      when(client.get(categoryUrl)).thenThrow(DioError());
      expect(
          () => api.getCategoryPosts(
                categoryUrl,
              ),
          throwsA(TypeMatcher<DioError>()));
    });

    test('Testing getCategoryPosts failure with ParserException', () {
      when(client.get(categoryUrl))
          .thenAnswer((realInvocation) async => noDataResponse);
      expect(
          () => api.getCategoryPosts(
              "https://spacetoday.com.br/category/categoryUrl/",
              page: 1),
          throwsA(TypeMatcher<ParserException>()));
    });
  });
}
