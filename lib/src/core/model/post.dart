class Post {
  final String contentUrl;
  final String imageUrl;
  final String title;
  final String categoryName;
  final String author;

  Post(
      {this.contentUrl,
      this.imageUrl,
      this.title,
      this.categoryName,
      this.author});

  @override
  String toString() =>
      'Title: $title\nCategory: $categoryName\nAuthor: $author\nUrl: $contentUrl\nImageUrl: $imageUrl';
}
