import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_list_app/screens/movie_screen.dart';
import 'package:provider/provider.dart';
import 'package:movie_list_app/providers/movie_provider.dart';

void main() {
  testWidgets('MovieListScreen displays correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => MovieProvider(),
        child: const MaterialApp(home: MovieListScreen()),
      ),
    );

    expect(find.text('Movie List'), findsOneWidget);
    expect(find.byType(ListTile), findsNothing);
  });
}
