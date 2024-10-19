
part of 'vf_lifecyclebloc.dart';

abstract class AppLifecycleState {}

class AppLifecycleInitial extends AppLifecycleState {}

class AppLifecyclePaused extends AppLifecycleState {}

class AppLifecycleResumed extends AppLifecycleState {}
