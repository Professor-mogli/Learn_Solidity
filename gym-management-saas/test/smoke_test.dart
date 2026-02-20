import 'package:flutter_test/flutter_test.dart';
import 'package:gym_management_saas/app/gym_app.dart';

void main() {
  testWidgets('renders login role buttons', (tester) async {
    await tester.pumpWidget(const GymApp());

    expect(find.text('Login as Super Admin'), findsOneWidget);
    expect(find.text('Login as Gym Owner'), findsOneWidget);
    expect(find.text('Login as Member'), findsOneWidget);
  });
}
