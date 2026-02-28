import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_home_overview.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeOverview getHomeOverview;
  HomeCubit({required this.getHomeOverview}) : super(const HomeInitial());

  Future<void> load() async {
    emit(const HomeLoading());
    try {
      final data = await getHomeOverview();
      emit(HomeLoaded(data));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}