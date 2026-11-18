import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_esparcia/main.dart';

void main() {
  testWidgets('App shows the menu screen', (WidgetTester tester) async {
    await tester.pumpWidget(const CanteenApp());
    expect(find.text('Canteen Menu'), findsOneWidget);
  });
}