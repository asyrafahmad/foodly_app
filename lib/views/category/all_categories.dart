import 'package:flutter/material.dart';

/// Screen that shows all categories.
/// - Stateless because it does not hold mutable state itself (state comes from controllers or parent widgets).
/// - Expand this file to include lists, grids, or other UI for displaying categories.
class AllCategories extends StatelessWidget {
  /// Const constructor for this stateless widget.
  /// Using `const` helps Flutter optimize rebuilds when possible.
  const AllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    // Builds the visual structure for the screen.
    return Scaffold(
      // Top app bar following Material Design.
      appBar: AppBar(
        // Title displayed in the app bar.
        title: const Text('All Categories'),
      ),
      // Body is intentionally left empty for now; replace with category list/grid.
    );
  }
}