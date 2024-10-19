import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/crud_repository/volufriend_crud_repo.dart';
import 'package:equatable/equatable.dart';

part 'get_users_event.dart';
part 'get_users_state.dart';

class GetUsersBloc extends Bloc<GetUsersEvent, GetUsersState> {
  GetUsersBloc({required this.vfcrudService}) : super(GetUsersLoading()) {
    on<GetUsers>(_onGetUsers);
  }

  final VolufriendCrudService vfcrudService;

  Future<void> _onGetUsers(GetUsers event, Emitter<GetUsersState> emit) async {
    emit(GetUsersLoading());
    try {
      final result = await vfcrudService.getUserList();
      emit(GetUsersLoaded(users: result));
      print("getusrloading");
    } catch (_) {
      emit(GetUsersError());
      print("error");
    }
  }
}
