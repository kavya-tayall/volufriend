part of 'vf_splash_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///VfSplash widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class VfSplashEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the VfSplash widget is first created.
class VfSplashInitialEvent extends VfSplashEvent {
  @override
  List<Object?> get props => [];
}
