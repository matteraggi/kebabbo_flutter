import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Adaptive FlexibleSpaceBar padding avoids overlap with back button and actions',
      (WidgetTester tester) async {
    const String testTitle = 'Super Mega Istanbul Kebab da Ciro Express';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 250.0,
                  pinned: true,
                  forceElevated: innerBoxIsScrolled,
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {},
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.bookmark),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.map),
                      onPressed: () {},
                    ),
                  ],
                  flexibleSpace: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      final settings = context
                          .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
                      final double t = settings != null &&
                              settings.maxExtent > settings.minExtent
                          ? ((settings.maxExtent - settings.currentExtent) /
                                  (settings.maxExtent - settings.minExtent))
                              .clamp(0.0, 1.0)
                          : 0.0;
                      final double leftPadding =
                          Tween<double>(begin: 16.0, end: 72.0).transform(t);
                      final double rightPadding =
                          Tween<double>(begin: 16.0, end: 100.0).transform(t);

                      return FlexibleSpaceBar(
                        titlePadding: EdgeInsets.only(
                          left: leftPadding,
                          bottom: 16,
                          right: rightPadding,
                        ),
                        centerTitle: false,
                        title: const Text(
                          testTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
                ),
              ];
            },
            body: ListView.builder(
              itemCount: 50,
              itemBuilder: (context, i) => ListTile(title: Text('Item $i')),
            ),
          ),
        ),
      ),
    );

    // Initial state: expanded (250px)
    final FlexibleSpaceBar initialBar =
        tester.widget(find.byType(FlexibleSpaceBar));
    expect(initialBar.titlePadding, isNotNull);
    final EdgeInsets initialPadding = initialBar.titlePadding! as EdgeInsets;
    expect(initialPadding.left, 16.0);
    expect(initialPadding.right, 16.0);

    // Scroll down by 300px to fully collapse the SliverAppBar
    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();

    // Collapsed state
    final FlexibleSpaceBar collapsedBar =
        tester.widget(find.byType(FlexibleSpaceBar));
    final EdgeInsets collapsedPadding = collapsedBar.titlePadding! as EdgeInsets;
    expect(collapsedPadding.left, 72.0);
    expect(collapsedPadding.right, 100.0);

    // Verify back button is located at left = 0..48/56
    final Rect backButtonRect = tester.getRect(find.byIcon(Icons.arrow_back));
    expect(backButtonRect.right, lessThanOrEqualTo(56.0));

    // Ensure title start position (72.0) is strictly greater than back button right edge
    expect(collapsedPadding.left, greaterThan(backButtonRect.right));
  });
}
