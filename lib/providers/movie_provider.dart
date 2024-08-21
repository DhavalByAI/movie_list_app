import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importing SharedPreferences for local storage.
import 'dart:convert'; // Importing dart:convert to handle JSON encoding and decoding.

import '../models/movie_model.dart'; // Importing the Movie model.

class MovieProvider with ChangeNotifier {
  // Private list of movies managed by the provider.
  List<Movie> _movies = [];

  // Getter to access the list of movies outside the provider.
  List<Movie> get movies => _movies;

  // Method to add a new movie to the list.
  void addMovie(String title, String description) {
    final movie = Movie(
        title: title, description: description); // Create a new movie instance.
    _movies.add(movie); // Add the movie to the list.
    notifyListeners(); // Notify listeners to rebuild UI if necessary.
    _saveMovies(); // Save the updated list of movies to local storage.
  }

  // Method to remove a movie from the list by index.
  void removeMovie(int index) {
    _movies.removeAt(index); // Remove the movie at the given index.
    notifyListeners(); // Notify listeners to update the UI.
    _saveMovies(); // Save the updated list to local storage.
  }

  // Method to toggle the favorite status of a movie.
  void toggleFavorite(int index) {
    _movies[index]
        .toggleFavorite(); // Toggle the isFavorite property of the movie at the given index.
    notifyListeners(); // Notify listeners to update the UI.
    _saveMovies(); // Save the updated list to local storage.
  }

  // Method to load movies from local storage when the app starts.
  Future<void> loadMovies() async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Get instance of SharedPreferences.
    String? moviesString = prefs.getString(
        'movies'); // Retrieve the saved movies string from SharedPreferences.

    if (moviesString != null) {
      List<dynamic> jsonData = jsonDecode(
          moviesString); // Decode the JSON string into a list of dynamic objects.
      _movies = jsonData
          .map((item) => Movie(
                title: item['title'],
                description: item['description'],
                isFavorite: item['isFavorite'],
              ))
          .toList(); // Convert each dynamic object to a Movie instance and store it in _movies list.
      notifyListeners(); // Notify listeners to rebuild UI with loaded data.
    }
  }

  // Private method to save the list of movies to local storage.
  Future<void> _saveMovies() async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Get instance of SharedPreferences.

    // Convert the list of Movie objects to a list of maps (JSON-like structure).
    List<Map<String, dynamic>> jsonData = _movies
        .map((movie) => {
              'title': movie.title,
              'description': movie.description,
              'isFavorite': movie.isFavorite,
            })
        .toList();

    // Encode the list of maps to a JSON string and save it in SharedPreferences.
    await prefs.setString('movies', jsonEncode(jsonData));
  }
}
