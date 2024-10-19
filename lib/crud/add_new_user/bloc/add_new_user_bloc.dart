import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/crud_repository/volufriend_crud_repo.dart';

part 'add_new_user_event.dart';
part 'add_new_user_state.dart';

class AddNewUserBloc extends Bloc<AddNewUserEvent, AddNewUserState> {
  final VolufriendCrudService vfcrudService;

  AddNewUserBloc({required this.vfcrudService}) : super(AddNewUserInitial()) {
    on<AddNewUser>((event, emit) async {
      emit(AddNewUserLoading());
      try {
        // Prepare user data for the service
        final Map<String, dynamic> userData = {
          'First Name': event.firstName,
          'Last Name': event.lastName,
          'dob': event.dob?.toIso8601String(),
          'email': event.email,
          'gender': event.gender,
          'phone': event.phone,
          'picture_url': event.pictureUrl,
          'role': event.role,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
          'school_home_org_id': event.schoolhomeorgid,
        };
        print("I am going to add following user data");
        print(userData);
        // Generate a unique ID (Firebase will do this on its own, but here it's for simulation)
        final String userId = event.userId;

        // Call the service to add a new user
        final result = await vfcrudService.addNewUser(userId, userData);

        // Emit the success state with user ID
        emit(AddNewUserLoaded(newUser: result));
      } catch (e) {
        // Emit the failure state with error message
        emit(AddNewUserFailure(e.toString()));
      }
    });
  }
}
