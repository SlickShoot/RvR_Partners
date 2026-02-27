import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String mainText;
  final String? secondaryText;

  const EmptyState({
    super.key,
    required this.mainText,
    this.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            mainText,
            style: const TextStyle(
              fontSize: 24,
              color: Color(0xFF929292),
              fontWeight: FontWeight.w700
            ),
          ),
          if (secondaryText != null) ...[
            const SizedBox(height: 8),
            Text(
              secondaryText!,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF929292),
                fontWeight: FontWeight.w400
              ),
            ),
          ],
        ],
      ),
    );
  }
}


