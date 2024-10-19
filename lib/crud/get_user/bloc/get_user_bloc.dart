import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/crud_repository/volufriend_crud_repo.dart';
import 'package:equatable/equatable.dart';

part 'get_user_event.dart';
part 'get_user_state.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  GetUserBloc({required this.vfcrudService}) : super(GetUserInitial()) {
    on<GetUser>(_onGetUser);
  }

  final VolufriendCrudService vfcrudService;

  Future<void> _onGetUser(GetUser event, Emitter<GetUserState> emit) async {
    emit(GetUserLoading());
    try {
      final result =
          await vfcrudService.getUser(event.userId); // Assuming userId is used
      emit(GetUserLoaded(user: result));
    } catch (e) {
      emit(GetUserError(error: e.toString()));
    }
  }
}
