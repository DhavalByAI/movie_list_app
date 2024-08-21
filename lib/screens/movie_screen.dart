import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart'; // Importing the MovieProvider to manage the movie list state.
import 'add_movie_screen.dart'; // Importing the screen to add a new movie.

// MovieListScreen is a StatelessWidget that displays a list of movies.
class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie List'), // Setting the title of the app bar.
      ),

      // The body of the scaffold uses a Consumer to access the MovieProvider.
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          return ListView.builder(
            itemCount: movieProvider
                .movies.length, // The number of movies in the list.
            itemBuilder: (context, index) {
              final movie = movieProvider
                  .movies[index]; // Accessing the movie at the current index.

              // Dismissible widget allows the user to swipe to delete a movie.
              return Dismissible(
                key: Key(movie.title), // Unique key for each dismissible item.
                background: Container(
                    color: Colors.red), // Background color when swiping.

                // Action performed when the movie is dismissed (swiped away).
                onDismissed: (direction) {
                  movieProvider
                      .removeMovie(index); // Removes the movie from the list.
                },

                // ListTile displays the movie details with a favorite button.
                child: ListTile(
                  title: Text(movie.title), // Displaying the movie title.
                  subtitle: Text(
                      movie.description), // Displaying the movie description.

                  // Favorite button to toggle favorite status of the movie.
                  trailing: IconButton(
                    icon: Icon(
                      movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: movie.isFavorite
                          ? Colors.red
                          : null, // Changes color if the movie is a favorite.
                    ),
                    onPressed: () {
                      movieProvider.toggleFavorite(
                          index); // Toggles the favorite status.
                    },
                  ),
                ),
              );
            },
          );
        },
      ),

      // Floating action button to navigate to the AddMovieScreen.
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add), // Icon for the floating action button.

        // Navigates to the AddMovieScreen when the button is pressed.
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const AddMovieScreen()), // Navigation to AddMovieScreen.
          );
        },
      ),
    );
  }
}
