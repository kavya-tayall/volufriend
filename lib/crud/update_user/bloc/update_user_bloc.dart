import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/crud_repository/volufriend_crud_repo.dart';
import 'package:equatable/equatable.dart';

part 'update_user_event.dart';
part 'update_user_state.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final VolufriendCrudService vfcrudService;

  UpdateUserBloc({required this.vfcrudService}) : super(UpdateUserInitial()) {
    on<UpdateUser>(_onUpdateUser);
  }

  Future<void> _onUpdateUser(
      UpdateUser event, Emitter<UpdateUserState> emit) async {
    emit(UpdateUserLoading());
    try {
      final result = await vfcrudService.updateUser(
        event.id,
        {
          'First Name': event.firstName,
          'Last Name': event.lastName,
          'dob': event.dob.toIso8601String(),
          'email': event.email,
          'gender': event.gender,
          'phone': event.phone,
          'pictureUrl': event.pictureUrl,
          'role': event.role,
          'updated_at': event.updatedAt.toIso8601String(),
        },
      );
      emit(UpdateUserLoaded(updatedUser: result));
    } catch (e) {
      emit(UpdateUserError(error: e.toString()));
    }
  }
}
