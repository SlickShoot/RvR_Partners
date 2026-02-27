import 'package:flutter/material.dart';

class SearchCard extends StatelessWidget {
  final VoidCallback? onSearchPressed;

  const SearchCard({
    super.key,
    this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Цвет тени с прозрачностью
            spreadRadius: 0.5,  // Радиус распространения
            blurRadius: 6,    // Размытие
            offset: Offset(0, 0), // Смещение (x, y)
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            width: 80,
            height: 90,
            child: Image.asset(
              'lib/assets/images/user.png',
              fit: BoxFit.cover
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Начните поиск сотрудников',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF8B8B8B),
            ),
          ),
          const Text(
            'прямо сейчас',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF8B8B8B),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onSearchPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5976D7),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Искать сотрудников',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


