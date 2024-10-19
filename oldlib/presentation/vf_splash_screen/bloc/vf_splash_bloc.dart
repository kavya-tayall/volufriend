import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/vf_splash_model.dart';
part 'vf_splash_event.dart';
part 'vf_splash_state.dart';

/// A bloc that manages the state of a VfSplash according to the event that is dispatched to it.
class VfSplashBloc extends Bloc<VfSplashEvent, VfSplashState> {
  VfSplashBloc(VfSplashState initialState) : super(initialState) {
    on<VfSplashInitialEvent>(_onInitialize);
  }

  _onInitialize(
    VfSplashInitialEvent event,
    Emitter<VfSplashState> emit,
  ) async {
    Future.delayed(const Duration(milliseconds: 3000), () {
      NavigatorService.popAndPushNamed(
        AppRoutes.vfOnboarding1Screen,
      );
    });
  }
}
