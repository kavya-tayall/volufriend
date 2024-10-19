import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volufriend/auth/bloc/org_event_bloc.dart';
import '/crud_repository/volufriend_crud_repo.dart';

part 'login_user_event.dart';
part 'login_user_state.dart';

//GetUserBloc({required this.vfcrudService}) : super(GetUserInitial()) {
class UserBloc extends Bloc<UserEvent, UserState> {
  final VolufriendCrudService
      vfcrudService; // Inject your service to make API calls

  UserBloc({required this.vfcrudService}) : super(UserInitial()) {
    on<CheckUserStatus>(_onCheckUserStatus);
    on<RegisterUserEvent>(_onRegisterUser);
    on<LoginUserEvent>(_onLoginUser);
    on<JoinHomeOrg>(_onJoinHomeOrg);
    on<LogoutEvent>(_onLogout);
  }

  // Check if the user is already logged in when the app starts
  Future<void> _onCheckUserStatus(
      CheckUserStatus event, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      // Check if the user object is null
      if (event.user == null) {
        // If no user object is provided, emit LoginRequired state
        UserHomeOrg? userData; // Initialize UserHomeOrg instance as null

        final LoginUser tempUser = LoginUser(
          userHomeOrg: userData,
          isLoggedIn: false,
        );

        // Set isLoggedIn to false
        emit(LoginRequired(user: tempUser));
      } else {
        // If a user object is provided, proceed with the normal flow
        //final LoginUser tempUser = event.user!;
        final userData =
            await vfcrudService.getloginUserHomeOrg(event.user!.userid!);
        final tempUser = LoginUser(
          userHomeOrg: userData,
          isLoggedIn: event.user!.isLoggedIn,
        );

        // Check if the user is logged in and has an associated organization
        if (tempUser.isLoggedIn == true) {
          if (userData.orgid == null || userData.orgid!.trim().isEmpty) {
            print("I am here orgid is null");
            emit(NoHomeOrg(user: tempUser));
          } else {
            print("I am here orgid is not rnull");
            print(tempUser);
            emit(LoginUserWithHomeOrg(user: tempUser));
          }
        } else {
          emit(UserInitial()); // User not logged in, show initial screen
        }
      }
    } catch (e) {
      // Handle any exceptions by emitting a LoginFail state
      emit(LoginFail(message: e.toString()));
    }
  }

// Handle user registration
  Future<void> _onRegisterUser(
      RegisterUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final userData = await vfcrudService.getloginUserHomeOrg(event.userId);

      final LoginUser tempUser = LoginUser(
        userHomeOrg: userData,
        isLoggedIn: false,
      );

      // Emit the LoginRequired state with the created LoginUser object
      emit(LoginRequired(user: tempUser));
    } catch (e) {
      // Handle any exceptions by emitting a RegisterFail state
      emit(RegisterFail(message: e.toString()));
    }
  }

  // Handle user login
  Future<void> _onLoginUser(
      LoginUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      // Call the API to get the user data using the provided userId
      final userId = event.userId;
      print('loggin user $userId');
      if (userId != null) {
        final userData = await vfcrudService.getloginUserHomeOrg(userId);

        print(userData);
        // Process userData...
        // Create a LoginUser object from the retrieved user data
        final tempUser = LoginUser(
          userHomeOrg: userData,
          isLoggedIn: true, // Set the user as logged in
        );
        if (tempUser.orgid == null || tempUser.orgid!.trim().isEmpty) {
          print("I am here orgid is null");
          emit(NoHomeOrg(user: tempUser));
        } else {
          print("I am here orgid is not null");
          emit(LoginUserWithHomeOrg(user: tempUser));
        }
      } else {
        emit(LoginFail(message: "User ID cannot be null."));
      }
    } catch (e) {
      emit(LoginFail(message: e.toString()));
    }
  }

  // Handle joining a home organization
  Future<void> _onJoinHomeOrg(
      JoinHomeOrg event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final requestBody = {
        "orgId": event.orgId,
        "role": event.role,
        "createdAt": event.createdAt,
        "createdBy": event.createdBy,
        "orgRole": event.orgRole
      };
      final userData =
          await vfcrudService.joinHomeOrg(event.userId, requestBody);
      final tempUser = LoginUser(
        userHomeOrg: userData,
        isLoggedIn: true, // Set the user as logged in
      );
      emit(LoginUserWithHomeOrg(user: tempUser));
    } catch (e) {
      emit(LoginFail(message: e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<UserState> emit) async {
    try {
      // Perform logout logic here, e.g., clearing user data

      emit(UserInitial()); // Emit initial state after logout
    } catch (e) {
      emit(LoginFail(message: e.toString()));
    }
  }
}
