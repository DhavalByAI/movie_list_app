class Movie {
  String title;
  String description;
  bool isFavorite;

  Movie({
    required this.title,
    required this.description,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }
}
