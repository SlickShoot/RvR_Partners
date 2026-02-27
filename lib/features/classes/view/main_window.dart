import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../../../repositories/partner_repository.dart';
import '../../../local_storage/user/partners_local_storage.dart';
import 'details_partner.dart';


class MainWindow extends StatefulWidget {
  const MainWindow({super.key, required this.title});

  final String title;

  @override
  State<MainWindow> createState() => MainWindowState();
}

class MainWindowState extends State<MainWindow> {
  // --- Состояние UI (только для отображения) ---
  String _selectedTab = 'Приняты';           // активная вкладка: «Приняты» или «Отклонены»
  bool _hasSearched = false;                 // показывать карточку анкеты или кнопку «Искать»
  bool _isLoading = false;                   // идёт загрузка следующей анкеты (индикатор)

  // --- Данные: текущая анкета и список просмотренных ---
  List<Map<String, dynamic>> _viewedProfiles = []; //все просмотренные анкеты
  Map<String, dynamic>? _currentProfile; //анкета с сервера

  // --- Backend: откуда берутся и куда сохраняются данные ---
  final PartnerRepository _partnerRepository = PartnerRepository();       // запросы к API
  final PartnersLocalStorage _partnersLocalStorage = PartnersLocalStorage(); // локальное хранилище

  @override
  void initState() {
    super.initState();
    _loadViewedFromStorage();
  }

  /// Загрузить ранее просмотренные анкеты из локального хранилища
  Future<void> _loadViewedFromStorage() async {
    final storedProfiles = await _partnersLocalStorage.loadViewedPartners();  //вызываем метод локального backend-а
    if (!mounted) return;

    setState(() {
      _viewedProfiles = storedProfiles;
    });
  }

  /// Сохранить текущий список просмотренных анкет в локальное хранилище
  Future<void> _saveViewedToStorage() async {
    await _partnersLocalStorage.saveViewedPartners(_viewedProfiles);
  }

  /// Загрузить следующую анкету из API
  Future<void> _loadNextProfile() async {
    setState(() {
      _isLoading = true;
      _hasSearched = true;
    });

    try {
      // Получаем нормализованный профиль из репозитория
      final profile = await _partnerRepository.getPartnerProfile();
      
      // Логируем полученные данные для отладки
      print('Получен профиль из API: $profile');
      
      setState(() {
        _currentProfile = profile;
        _isLoading = false; //рисуем искать сотрудников
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasSearched = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка загрузки профиля: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Обработчик первого нажатия на кнопку "Искать сотрудников"
  Future<void> _handleSearch() async {
    await _loadNextProfile();
  }

  void _handleDecline() {
    if (_currentProfile != null) {
      final declinedProfile = _currentProfile!;

      // Добавляем текущую анкету в список как "Отклонены"
      setState(() {
        _viewedProfiles.add({...declinedProfile, 'status': 'Отклонены'});
      });
      // Сохраняем обновлённый список локально
      _saveViewedToStorage();

      // Загружаем следующую анкету, не показывая снова кнопку поиска
      _loadNextProfile();
    }
  }

  void _handleAccept() {
    if (_currentProfile != null) {
      final acceptedProfile = _currentProfile!;

      // Добавляем текущую анкету в список как "Приняты"
      setState(() {
        _viewedProfiles.add({...acceptedProfile, 'status': 'Приняты'});
      });
      // Сохраняем обновлённый список локально
      _saveViewedToStorage();

      // Загружаем следующую анкету, не показывая снова кнопку поиска
      _loadNextProfile();
    }
  }
  
  List<Map<String, dynamic>> get _filteredProfiles {
    // Показываем все профили, которые имеют статус, соответствующий выбранной вкладке
    return _viewedProfiles.where((profile) => profile['status'] == _selectedTab).toList();
  }
  
  // Получить все профили для отображения (без фильтрации)
  List<Map<String, dynamic>> get _allProfiles {
    return _viewedProfiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_isLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (_hasSearched && _currentProfile != null)
                      ProfileCard(
                        name: _currentProfile!['name']?.toString() ?? 'Не указано',
                        age: _currentProfile!['age'] is int 
                            ? _currentProfile!['age'] as int
                            : int.tryParse(_currentProfile!['age']?.toString() ?? '0') ?? 0,
                        gender: _currentProfile!['gender']?.toString() ?? 'Не указано',
                        position: _currentProfile!['position']?.toString() ?? 'Не указано',
                        nationality: _currentProfile!['nationality']?.toString() ?? 'Не указано',
                        city: _currentProfile!['city']?.toString() ?? 'Не указано',
                        description: _currentProfile!['description']?.toString() ?? 'Описание отсутствует',
                        onDecline: _handleDecline,
                        onAccept: _handleAccept,
                      )
                    else
                      SearchCard(
                        onSearchPressed: _handleSearch,
                      ),
                    
                    const SizedBox(height: 32),
                    
                    const Text(
                      'Просмотренные анкеты',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF212121),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 126,
                          height: 46,
                          child: TabButton(
                            text: 'Отклонены',
                            isSelected: _selectedTab == 'Отклонены',
                            onTap: () {
                              setState(() {
                                _selectedTab = 'Отклонены';
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 126,
                          height: 46,
                          child: TabButton(
                            text: 'Приняты',
                            isSelected: _selectedTab == 'Приняты',
                            onTap: () {
                              setState(() {
                                _selectedTab = 'Приняты';
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 52),
                    
                    if (_filteredProfiles.isNotEmpty)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            ...List.generate(
                              _filteredProfiles.length,
                              (index) {
                                final profile = _filteredProfiles[index];
                                return ProfileListItem(
                                  name: profile['name']?.toString() ?? 'Не указано',
                                  age: profile['age'] is int 
                                      ? profile['age'] as int
                                      : int.tryParse(profile['age']?.toString() ?? '0') ?? 0,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsPartner(profile: profile),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    else if (_allProfiles.isEmpty)
                      const EmptyState(
                        mainText: 'Пока никого нет',
                        secondaryText: 'Начните просмотр анкет сотрудников',
                      )
                    else
                      const EmptyState(
                        mainText: 'В этой категории пока никого нет',
                        secondaryText: '',
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
