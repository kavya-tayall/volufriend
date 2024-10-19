// In vf_volunteerWelcomescreen_state.dart
part of 'vf_volunteerWelcomescreen_bloc.dart';

class VfvolunteerWelcomescreenState extends Equatable {
  final VfvolunteerWelcomescreenModel vfvolunteerWelcomescreenModelObj;
  final bool isNoHomeOrgState; // Add this

  VfvolunteerWelcomescreenState({
    required this.vfvolunteerWelcomescreenModelObj,
    this.isNoHomeOrgState = false, // Default to false
  });

  VfvolunteerWelcomescreenState copyWith({
    VfvolunteerWelcomescreenModel? vfvolunteerWelcomescreenModelObj,
    bool? isNoHomeOrgState, // Add this
  }) {
    return VfvolunteerWelcomescreenState(
      vfvolunteerWelcomescreenModelObj: vfvolunteerWelcomescreenModelObj ??
          this.vfvolunteerWelcomescreenModelObj,
      isNoHomeOrgState: isNoHomeOrgState ?? this.isNoHomeOrgState, // Add this
    );
  }

  @override
  List<Object?> get props =>
      [vfvolunteerWelcomescreenModelObj, isNoHomeOrgState];
}
