import '../../domain/entities/home_overview.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_ds.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource local;
  HomeRepositoryImpl({required this.local});

  @override
  Future<HomeOverview> getOverview() => local.getOverview();
}