import 'package:flutter_test/flutter_test.dart';
import 'package:final_project/main.dart';

void main() {
  testWidgets('TableTap role selection loads', (WidgetTester tester) async {
    await tester.pumpWidget(const TableTapApp());

    expect(find.text('TableTap'), findsOneWidget);
    expect(find.text('Customer'), findsOneWidget);
    expect(find.text('Staff'), findsOneWidget);
  });
}