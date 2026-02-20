import 'package:flutter_test/flutter_test.dart';
import 'package:gym_management_saas/app/gym_app.dart';

void main() {
  testWidgets('renders role segmented login and demo buttons', (tester) async {
    await tester.pumpWidget(const GymApp());

    expect(find.text('Gym Management SaaS'), findsOneWidget);
    expect(find.text('Super Admin'), findsOneWidget);
    expect(find.text('Gym Owner'), findsOneWidget);
    expect(find.text('Member'), findsOneWidget);
    expect(find.text('Use Admin Demo'), findsOneWidget);
  });
}
