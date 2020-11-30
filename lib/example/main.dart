import 'package:dio/dio.dart';
import 'package:spacetoday_crawler/spacetoday_crawler.dart';

main() async {
  final SpaceTodayApi api = SpaceTodayApi(Dio());

  final data = await api.getAllPosts(page: 5);
  data.forEach((element) => print);

  final homePage = await api.getHomePage();

  print("Total categories: ${homePage.categories.length}");
  print("Total posts: ${homePage.posts.length}");

  print("====== The post titles are:");
  homePage.posts.forEach((element) => print(element.title));

  print("\n====== The categories are:");
  homePage.categories.forEach((element) => print(element.name));

  final results = await api.search("marte");
  print("\n====== Search results for \"marte\"");
  results.forEach((element) => print(element.title));

  final postContent = await api.getPostContent(homePage.posts.first.contentUrl);

  print("====== Post content: ");
  print(postContent);
}
