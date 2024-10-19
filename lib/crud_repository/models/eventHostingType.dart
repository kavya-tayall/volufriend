import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class EventHostingType extends Equatable {
  final String id;
  final String? option;

  const EventHostingType({
    required this.id,
    this.option,
  });

  @override
  List<Object?> get props => [id, option];
}
