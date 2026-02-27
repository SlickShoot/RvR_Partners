import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class DetailsPartner extends StatelessWidget {
  final Map<String, dynamic> profile;

  const DetailsPartner({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(showBackButton: true),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProfileCard(
                      showAvatar: false,
                      name: profile['name']?.toString() ?? 'Не указано',
                      age: profile['age'] is int 
                          ? profile['age'] as int
                          : int.tryParse(profile['age']?.toString() ?? '0') ?? 0,
                      gender: profile['gender']?.toString() ?? 'Не указано',
                      position: profile['position']?.toString() ?? 'Не указано',
                      nationality: profile['nationality']?.toString() ?? 'Не указано',
                      city: profile['city']?.toString() ?? 'Не указано',
                      description: profile['description']?.toString() ?? 'Описание отсутствует',
                      onDecline: null,
                      onAccept: null,
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFF3C539F),
                        ),
                        label: const Text(
                          'Назад',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF3C539F),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
