import 'package:flutter/material.dart';

class ProfileListItem extends StatelessWidget {
  final String name;
  final int age;
  final VoidCallback? onTap;

  const ProfileListItem({
    super.key,
    required this.name,
    required this.age,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFE0E0E0),
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF212121),
                ),
              ),
            ),
            Text(
              '$age лет',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF212121),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right,
              color: Color(0xFF9E9E9E),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}


