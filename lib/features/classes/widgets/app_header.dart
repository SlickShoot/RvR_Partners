import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final bool showBackButton;
  
  const AppHeader({
    super.key,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF5976D7)
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Стрелка назад слева (если нужно)
          if (showBackButton)
            Positioned(
              left: 0,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          // Иконка человека слева (если стрелки нет)
          if (!showBackButton)
            const Positioned(
              left: 0,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 24,
              ),
            ),
          // Текст по центру
          const Text(
            'RvR Partners',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}


