part of 'app_navigation_bloc.dart';

/// Abstract class for all events that can be dispatched from the
/// AppNavigation widget.
///
/// Events must be immutable and implement the [Equatable] interface.
abstract class AppNavigationEvent extends Equatable {
  const AppNavigationEvent();

  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the AppNavigation widget is first created.
class AppNavigationInitialEvent extends AppNavigationEvent {
  final String? sourceScreen; // The source screen or context

  const AppNavigationInitialEvent({this.sourceScreen});

  @override
  List<Object?> get props => [sourceScreen];
}

class AppNavigationPopEvent extends AppNavigationEvent {
  final String? sourceScreen; // The source screen or context

  const AppNavigationPopEvent({this.sourceScreen});

  @override
  List<Object?> get props => [sourceScreen];
}

class AppNavigationPushEvent extends AppNavigationEvent {
  final String? destinationScreen; // The destination screen or context

  const AppNavigationPushEvent({this.destinationScreen});

  @override
  List<Object?> get props => [destinationScreen];
}
