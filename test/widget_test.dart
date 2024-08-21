import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('End-to-End Test', (WidgetTester tester) async {
    await tester.pumpAndSettle();

    // Add a movie
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Test Movie');
    await tester.enterText(
        find.byType(TextFormField).at(1), 'Test Description');
    await tester.tap(find.text('Add Movie'));
    await tester.pumpAndSettle();

    expect(find.text('Test Movie'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);

    // Mark as favorite
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    // Remove the movie
    await tester.drag(find.byType(ListTile), Offset(-500.0, 0.0));
    await tester.pumpAndSettle();
    expect(find.text('Test Movie'), findsNothing);
  });
}
