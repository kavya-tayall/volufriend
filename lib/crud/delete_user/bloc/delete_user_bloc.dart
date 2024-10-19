import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '/crud_repository/volufriend_crud_repo.dart';

part 'delete_user_event.dart';
part 'delete_user_state.dart';

class DeleteUserBloc extends Bloc<DeleteUserEvent, DeleteUserState> {
  final VolufriendCrudService vfcrudService;

  DeleteUserBloc({required this.vfcrudService}) : super(DeleteUserInitial()) {
    on<DeleteUser>((event, emit) async {
      emit(DeleteUserLoading());
      try {
        await vfcrudService.deleteUser(event.id);
        emit(DeleteUserLoaded());
      } catch (error) {
        emit(DeleteUserError(error: error.toString()));
      }
    });
  }
}
