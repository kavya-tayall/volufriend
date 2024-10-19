part of 'vf_splash_bloc.dart';

/// Represents the state of VfSplash in the application.

// ignore_for_file: must_be_immutable
class VfSplashState extends Equatable {
  VfSplashState({this.vfSplashModelObj});

  VfSplashModel? vfSplashModelObj;

  @override
  List<Object?> get props => [vfSplashModelObj];
  VfSplashState copyWith({VfSplashModel? vfSplashModelObj}) {
    return VfSplashState(
      vfSplashModelObj: vfSplashModelObj ?? this.vfSplashModelObj,
    );
  }
}
