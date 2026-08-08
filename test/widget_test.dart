import 'package:flutter_test/flutter_test.dart';

import 'package:yks_coach/main.dart';

void main() {
  testWidgets('çalışma planı ekranı açılır', (WidgetTester tester) async {
    await tester.pumpWidget(const YksCoachApp());

    expect(find.text('AI çalışma planı'), findsOneWidget);
    expect(find.text('Çalışma planı oluştur'), findsOneWidget);
  });
}
