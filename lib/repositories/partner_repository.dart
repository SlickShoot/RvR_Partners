import 'package:dio/dio.dart';

// ═══════════════════════════════════════════════════════════════════════════
// BACKEND (слой данных): работа с удалённым сервером
// ═══════════════════════════════════════════════════════════════════════════
// Репозиторий отвечает за запросы к API: отправка HTTP-запросов, получение
// и нормализация ответа. Frontend (экраны и виджеты) не обращается к API
// напрямую — только через этот класс.
// ═══════════════════════════════════════════════════════════════════════════

class PartnerRepository {
  // HTTP-клиент для запросов к серверу
  final Dio _dio = Dio();
  // Адрес API (бэкенд на стороне сервера r-v-r.online)
  final String _baseUrl = 'https://r-v-r.online/rest_api/echo/';

  /// Получить анкету сотрудника
  /// Каждый запрос возвращает разного человека
  /// Возвращает нормализованные данные профиля
  Future<Map<String, dynamic>> getPartnerProfile() async {
    try {
      final response = await _dio.post(
        _baseUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Логируем сырой ответ для отладки
        print('Raw API response: ${response.data}');
        print('Response type: ${response.data.runtimeType}');
        
        // Проверяем тип данных ответа
        Map<String, dynamic> rawData;
        if (response.data is Map<String, dynamic>) {
          rawData = response.data as Map<String, dynamic>;
          print('Parsed data keys: ${rawData.keys.toList()}');
        } else if (response.data is String) {
          // Если ответ приходит как строка, пытаемся распарсить JSON
          try {
            rawData = response.data as Map<String, dynamic>;
          } catch (e) {
            print('Error parsing string response: $e');
            throw Exception('Failed to parse response');
          }
        } else {
          // Если это другой тип, возвращаем как есть
          print('Unexpected response type, wrapping in data key');
          rawData = {'data': response.data};
        }
        
        // Нормализуем данные профиля
        return _normalizeProfile(rawData);
      } else {
        throw Exception('Failed to load partner profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching partner profile: $e');
    }
  }

  /// Нормализация данных профиля из API
  /// Обрабатывает различные варианты структуры JSON
  /// Маппит ключи API на стандартные ключи приложения
  Map<String, dynamic> _normalizeProfile(Map<String, dynamic> rawProfile) {
    // API возвращает данные в структуре {status: success, data: {...}}
    // Извлекаем данные из ключа 'data'
    Map<String, dynamic> profileData;
    if (rawProfile.containsKey('data') && rawProfile['data'] is Map<String, dynamic>) 
    {
      profileData = rawProfile['data'] as Map<String, dynamic>;
    } 
    else 
    {
      profileData = rawProfile;
    }
    
    // Маппим ключи API на ключи приложения
    return {
      'name': profileData['name']?.toString() ?? '',
      'age': profileData['age'] is int 
          ? profileData['age'] as int
          : int.tryParse(profileData['age']?.toString() ?? '0') ?? 0,
      'gender': profileData['gender']?.toString() ?? '',
      'position': profileData['specialization']?.toString() ?? 
                  profileData['position']?.toString() ?? 
                  '',
      'nationality': profileData['nationality']?.toString() ?? '',
      'city': profileData['town']?.toString() ?? 
              profileData['city']?.toString() ?? 
              '',
      'description': profileData['about']?.toString() ?? 
                    profileData['description']?.toString() ?? 
                    '',
    };
  }
}

