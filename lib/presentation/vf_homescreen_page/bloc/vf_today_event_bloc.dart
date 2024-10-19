import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/crud_repository/volufriend_crud_repo.dart'; // Update with your repository

part 'vf_today_event_event.dart';
part 'vf_today_event_state.dart';

class VfTodayEventBloc extends Bloc<VfTodayEventEvent, vfTodayEventState> {
  final VolufriendCrudService vfcrudService;

  VfTodayEventBloc({required this.vfcrudService}) : super(EventInitial()) {
    on<FetchFirstEventOfDay>(_fetchFirstEventOfDay);
  }

  Future<void> _fetchFirstEventOfDay(
    FetchFirstEventOfDay event,
    Emitter<vfTodayEventState> emit,
  ) async {
    emit(EventLoading());
    try {
      final todayevent = await vfcrudService.getFirstEventOfDay();
      emit(EventLoaded(todayevent: todayevent));
    } catch (e) {
      emit(EventError(error: e.toString()));
    }
  }
}
