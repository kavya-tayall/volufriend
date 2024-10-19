import 'package:equatable/equatable.dart';
import '/crud_repository/volufriend_crud_repo.dart';

/// This class defines the variables used in the [vf_volunteer_welcomescreen_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class VfvolunteerWelcomescreenModel extends Equatable {
  final LoginUser? loginUser;

  VfvolunteerWelcomescreenModel({
    this.loginUser,
  });

  /// Creates a copy of the current object with optional new values for properties.
  VfvolunteerWelcomescreenModel copyWith({
    LoginUser? loginUser,
  }) {
    return VfvolunteerWelcomescreenModel(
      loginUser: loginUser ?? this.loginUser,
    );
  }

  @override
  List<Object?> get props => [loginUser];
}
