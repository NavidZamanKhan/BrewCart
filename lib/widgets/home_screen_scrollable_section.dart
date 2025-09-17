import 'package:flutter/material.dart';

class HomeScreenScrollableSection extends StatelessWidget {
  const HomeScreenScrollableSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 1; i <= 100; i++) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Section $i'),
            ),
          ],
        ],
      ),
    );
  }
}
