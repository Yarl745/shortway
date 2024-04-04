import 'package:equatable/equatable.dart';

/// Represents a generic failure from an operation or process.
class Failure extends Equatable {
  /// The message describing the failure.
  final String errorMessage;

  @override
  List<Object> get props => [];

  /// Constructs a Failure with an optional error message.
  const Failure({
    this.errorMessage = 'Unexpected error occurred',
  });

  @override
  String toString() {
    return "Failure(errorMessage: $errorMessage)";
  }
}
