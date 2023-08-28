import 'package:get/get.dart';

import '../../features/crud_notes/presentation/presentation.dart';
import '../core.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
