import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// ═══════════════════════════════════════════════════════════════════════════
// BACKEND (слой данных): локальное хранилище на устройстве
// ═══════════════════════════════════════════════════════════════════════════
// Сохраняет и загружает данные без сети (SharedPreferences). Используется
// для кэша просмотренных анкет «Приняты» / «Отклонены», чтобы они не терялись
// при закрытии приложения. Frontend читает/пишет через этот класс.
// ═══════════════════════════════════════════════════════════════════════════

/// Локальное хранилище просмотренных партнёров
/// Хранит список Map<String, dynamic> с полями:
/// name, age, gender, position, nationality, city, description, status
class PartnersLocalStorage {
  static const String _keyViewedPartners = 'viewed_partners';

  /// Сохранить список просмотренных партнёров
  Future<void> saveViewedPartners(List<Map<String, dynamic>> profiles) async {
    final prefs = await SharedPreferences.getInstance();

    // Кодируем каждый профиль в строку JSON
    final encodedList = profiles.map((profile) => jsonEncode(profile)).toList();

    await prefs.setStringList(_keyViewedPartners, encodedList);
  }

  /// Загрузить список просмотренных партнёров
  Future<List<Map<String, dynamic>>> loadViewedPartners() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList = prefs.getStringList(_keyViewedPartners);

    if (encodedList == null) {
      return [];
    }

    return encodedList.map((str) => jsonDecode(str) as Map<String, dynamic>).toList();
  }

  /// Очистить список просмотренных партнёров
  Future<void> clearViewedPartners() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyViewedPartners);
  }
}



