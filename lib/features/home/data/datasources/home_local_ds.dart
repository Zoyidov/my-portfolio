import '../../domain/entities/home_overview.dart';

abstract class HomeLocalDataSource {
  Future<HomeOverview> getOverview();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<HomeOverview> getOverview() async {
    return const HomeOverview(
      name: 'Nurmuxammad',
      title: 'Flutter Developer specializing in cross-platform mobile applications',
      location: 'Tashkent, Uzbekistan',
      timezone: 'UTC+5 (GMT+5)',
      currentFocus: 'ChortoqGo MVP',
      focusStatus: 'In Progress',
      activeProjects: 3,
      activeDelta: '+1 this month',
      availability: 'Busy',
      availabilityNote: 'Until March 2026',
      tasksDone: 24,
      tasksTotal: 32,
    );
  }
}