import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart'; // Importing the MovieProvider to manage the movie list state.

// AddMovieScreen is a StatefulWidget that allows the user to add a new movie.
class AddMovieScreen extends StatefulWidget {
  const AddMovieScreen({super.key});

  @override
  _AddMovieScreenState createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  final _formKey = GlobalKey<
      FormState>(); // GlobalKey to identify the form and manage its state.
  String _title = ''; // Variable to store the movie title input.
  String _description = ''; // Variable to store the movie description input.

  // Method to handle form submission.
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!
          .save(); // Save the form state (invoke onSaved callbacks).

      // Add the movie to the provider and navigate back to the previous screen.
      Provider.of<MovieProvider>(context, listen: false)
          .addMovie(_title, _description);
      Navigator.of(context)
          .pop(); // Pop the current screen after adding the movie.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Movie'), // Setting the title of the app bar.
      ),

      // Padding to add spacing around the form.
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Associating the form with the _formKey.
          child: Column(
            children: [
              // TextFormField for movie title input.
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Title'), // Input decoration with a label.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title'; // Validation message if the title is empty.
                  }
                  return null;
                },
                onSaved: (value) {
                  _title =
                      value!; // Save the entered title to the _title variable.
                },
              ),

              // TextFormField for movie description input.
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Description'), // Input decoration with a label.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description'; // Validation message if the description is empty.
                  }
                  return null;
                },
                onSaved: (value) {
                  _description =
                      value!; // Save the entered description to the _description variable.
                },
              ),

              const SizedBox(
                  height:
                      20), // Adding some space between the input fields and the button.

              // ElevatedButton to submit the form and add the movie.
              ElevatedButton(
                onPressed:
                    _submitForm, // Trigger form submission when the button is pressed.
                child: const Text('Add Movie'), // Button text.
              ),
            ],
          ),
        ),
      ),
    );
  }
}
