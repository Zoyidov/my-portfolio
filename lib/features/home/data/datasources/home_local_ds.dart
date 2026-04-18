import '../../domain/entities/home_overview.dart';

abstract class HomeLocalDataSource {
  Future<HomeOverview> getOverview();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<HomeOverview> getOverview() async {
    return const HomeOverview(
      name: 'Nurmuxammad',
      lastName: "Zoyidov",
      title: 'Flutter Developer specializing in cross-platform mobile applications',
      location: 'Fergana, Uzbekistan',
      timezone: 'UTC+5 (GMT+5)',
      currentFocus: 'ChortoqGo MVP',
      focusStatus: 'In Progress',
      activeProjects: 6,
      activeDelta: '+4 this month',
      availability: 'Busy',
      availabilityNote: 'Until 2027',
      tasksDone: 32,
      tasksTotal: 48,
    );
  }
}
