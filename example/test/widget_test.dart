// Copyright (c) 2026 Mudit Purohit
//
// This source code is licensed under the MIT license found in the
// LICENSE file in the root directory of this source tree.

import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';

void main() {
  testWidgets('M3E Menu Example App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const M3EMenuExampleApp());
    await tester.pumpAndSettle();

    // Verify title and main sections render
    expect(find.text('Material 3 Expressive Menus'), findsOneWidget);
    expect(find.text('1. Cascading Menus & Submenus'), findsOneWidget);
    expect(find.text('2. Checkbox & Radio Menu Items'), findsOneWidget);

    // Tap file actions menu button to open menu
    await tester.tap(find.text('File Actions (Cascading)'));
    await tester.pumpAndSettle();

    // Verify items in the opened menu
    expect(find.text('Open File...'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
    expect(find.text('Export As'), findsOneWidget);
  });
}
