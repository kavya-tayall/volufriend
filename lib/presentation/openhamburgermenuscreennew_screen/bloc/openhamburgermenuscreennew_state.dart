part of 'openhamburgermenuscreennew_bloc.dart';

/// Represents the state of Openhamburgermenuscreennew in the application.

// ignore_for_file: must_be_immutable
class OpenhamburgermenuscreennewState extends Equatable {
  OpenhamburgermenuscreennewState({this.openhamburgermenuscreennewModelObj});

  OpenhamburgermenuscreennewModel? openhamburgermenuscreennewModelObj;

  @override
  List<Object?> get props => [openhamburgermenuscreennewModelObj];
  OpenhamburgermenuscreennewState copyWith(
      {OpenhamburgermenuscreennewModel? openhamburgermenuscreennewModelObj}) {
    return OpenhamburgermenuscreennewState(
      openhamburgermenuscreennewModelObj: openhamburgermenuscreennewModelObj ??
          this.openhamburgermenuscreennewModelObj,
    );
  }
}
