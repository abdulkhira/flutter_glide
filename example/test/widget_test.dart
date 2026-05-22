import 'package:flutter_test/flutter_test.dart';
import 'package:swift_image_example/main.dart';

void main() {
  testWidgets('SwiftImage example app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const FlutterGlideExampleApp());
    expect(find.text('flutter_glide Demo'), findsOneWidget);
  });
}
