import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ptst_app/main.dart';

void main() {
  testWidgets('PTST app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: PtstApp(),
      ),
    );
    expect(find.byType(PtstApp), findsOneWidget);
  });
}
