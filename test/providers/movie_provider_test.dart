import 'package:flutter_test/flutter_test.dart';
import 'package:movie_list_app/providers/movie_provider.dart';

void main() {
  group('MovieProvider', () {
    test('should add a movie', () {
      final provider = MovieProvider();
      provider.addMovie('Title 1', 'Description 1');
      expect(provider.movies.length, 1);
      expect(provider.movies[0].title, 'Title 1');
    });

    test('should remove a movie', () {
      final provider = MovieProvider();
      provider.addMovie('Title 1', 'Description 1');
      provider.removeMovie(0);
      expect(provider.movies.length, 0);
    });

    test('should toggle favorite status', () {
      final provider = MovieProvider();
      provider.addMovie('Title 1', 'Description 1');
      provider.toggleFavorite(0);
      expect(provider.movies[0].isFavorite, true);
      provider.toggleFavorite(0);
      expect(provider.movies[0].isFavorite, false);
    });
  });
}
