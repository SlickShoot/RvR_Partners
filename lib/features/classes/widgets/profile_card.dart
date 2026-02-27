import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final bool showAvatar;
  final String name;
  final int age;
  final String gender;
  final String position;
  final String nationality;
  final String city;
  final String description;
  final VoidCallback? onDecline;
  final VoidCallback? onAccept;

  const ProfileCard({
    super.key,
    required this.name,
    required this.age,
    required this.gender,
    required this.position,
    required this.nationality,
    required this.city,
    required this.description,
    this.onDecline,
    this.onAccept,
    this.showAvatar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showAvatar && onDecline == null && onAccept == null)
            Center(
              child: Container(
                width: 80,
                height: 80,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Color(0xFF9E9E9E),
                ),
              ),
            ),
          
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF212121),
            ),
          ),
          const SizedBox(height: 16),
          
          _buildInfoRow('Возраст', '$age'),
          const SizedBox(height: 8),
          _buildInfoRow('Гендер', gender),
          const SizedBox(height: 8),
          _buildInfoRow('Должность', position),
          const SizedBox(height: 8),
          _buildInfoRow('Национальность', nationality),
          const SizedBox(height: 8),
          _buildInfoRow('Город', city),
          
          const SizedBox(height: 16),
          
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF424242),
              height: 1.4,
            ),
          ),
          
          if (onDecline != null && onAccept != null) ...[
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onDecline,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF5976D7),
                      side: const BorderSide(
                        color: Color(0xFF5976D7),
                        width: 1,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Отклонить',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onAccept,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5976D7),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Принять',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF757575),
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF212121),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}


