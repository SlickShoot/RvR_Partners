import '../features/classes/view/view.dart';

final routes = {
  '/': (context) => const MainWindow(title: 'Flutter Demo Home Page'),       // главный экран
  '/selection_partners': (context) => const SelectionPartners()              // экран выбора партнёров
};