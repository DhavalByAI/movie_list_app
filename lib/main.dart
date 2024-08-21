import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/movie_provider.dart';
import 'screens/movie_screen.dart';

// The main function serves as the entry point for the Flutter app.
void main() {
  runApp(const MyApp()); // Runs the MyApp widget.
}

// MyApp is the root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // MovieProvider is provided to the widget tree, allowing any descendant widget to access it.
      create: (context) => MovieProvider()
        ..loadMovies(), // Initializes the provider and loads movies from local storage.

      // MaterialApp is the root of the widget hierarchy, providing basic material design layout and theming.
      child: MaterialApp(
        debugShowCheckedModeBanner:
            false, // Hides the debug banner in the top-right corner of the app.
        title: 'Movie List App', // Sets the title of the application.
        theme: ThemeData(
          primarySwatch:
              Colors.blue, // Sets the primary theme color of the app.
        ),
        home:
            const MovieListScreen(), // Sets the home screen of the app to MovieListScreen.
      ),
    );
  }
}
