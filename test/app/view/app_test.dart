import 'package:flutter_test/flutter_test.dart';
import 'package:siakad_sma_al_fusha/app/app.dart';
import 'package:siakad_sma_al_fusha/counter/counter.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
