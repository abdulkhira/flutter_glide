import 'package:flutter_test/flutter_test.dart';
import 'package:swift_image_example/main.dart';

void main() {
  testWidgets('SwiftImage example app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SwiftImageExampleApp());
    expect(find.text('SwiftImage Demo'), findsOneWidget);
  });
}
