import '../entities/home_overview.dart';
import '../repositories/home_repository.dart';

class GetHomeOverview {
  final HomeRepository repo;
  GetHomeOverview(this.repo);

  Future<HomeOverview> call() => repo.getOverview();
}