import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class GenderOptions extends Equatable {
  final String id;
  final String? option;

  const GenderOptions({
    required this.id,
    this.option,
  });

  @override
  List<Object?> get props => [id, option];
}
