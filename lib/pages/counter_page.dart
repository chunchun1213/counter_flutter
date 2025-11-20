import 'package:flutter/material.dart';
import 'package:counter_flutter/theme/app_colors.dart';
import 'package:counter_flutter/theme/app_text_styles.dart';
import 'package:counter_flutter/theme/app_theme.dart';

/// Main counter page widget.
///
/// Displays a counter interface with:
/// - Gradient background
/// - White card container with counter display and title
/// - Floating action button to increment the counter
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _count = 0;

  /// Increments the counter by 1.
  void incrementCounter() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: Center(
          child: SizedBox(
            width: AppTheme.cardWidth,
            height: AppTheme.cardHeight,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
              ),
              color: AppColors.white,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppTheme.cardBorderRadius,
                  ),
                  boxShadow: AppTheme.cardShadows,
                  color: AppColors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppTheme.mediumPadding,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Title
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.mediumPadding,
                        ),
                        child: Text(
                          '計數器',
                          key: const Key('counter_title'),
                          style: AppTextStyles.title,
                          semanticsLabel: '計數器標題',
                        ),
                      ),
                      // Counter display
                      Semantics(
                        label: '當前計數：$_count',
                        child: Text(
                          '$_count',
                          key: const Key('counter_display'),
                          style: AppTextStyles.counter,
                        ),
                      ),
                      // Circular button
                      Container(
                        width: AppTheme.buttonSize,
                        height: AppTheme.buttonSize,
                        decoration: BoxDecoration(
                          color: AppColors.buttonBlue,
                          shape: BoxShape.circle,
                          boxShadow: AppTheme.buttonShadows,
                        ),
                        child: IconButton(
                          key: const Key('increment_button'),
                          onPressed: incrementCounter,
                          icon: const Icon(Icons.add, color: AppColors.white),
                          tooltip: '增加計數',
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
