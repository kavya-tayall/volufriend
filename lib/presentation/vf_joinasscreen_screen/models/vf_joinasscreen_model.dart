import 'package:equatable/equatable.dart';

/// This class defines the variables used in the [vf_joinasscreen_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class VfJoinasscreenModel extends Equatable {
  final String joinAs;

  VfJoinasscreenModel({required this.joinAs});

  /// This method creates a copy of the object with an optional new value for `joinAs`.
  VfJoinasscreenModel copyWith({String? joinAs}) {
    return VfJoinasscreenModel(
      joinAs: joinAs ?? this.joinAs,
    );
  }

  @override
  List<Object?> get props => [joinAs];
}
