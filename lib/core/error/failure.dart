import 'dart:math';

import 'package:equatable/equatable.dart';

/// Represents a generic failure from an operation or process.
class Failure extends Equatable {
  /// The code describing the failure.
  final int? errorCode;

  /// The message describing the failure.
  final String? errorMessage;

  @override
  List<Object> get props => [Random().nextInt(1000)];

  /// Constructs a Failure with an optional error message and code.
  const Failure({
    this.errorCode = 400,
    this.errorMessage = 'Unexpected error occurred',
  });

  @override
  String toString() {
    return "$runtimeType(errorMessage: $errorMessage)";
  }
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure({super.errorCode, super.errorMessage});
}

class NotCorrectUrlFailure extends Failure {
  const NotCorrectUrlFailure({super.errorCode, super.errorMessage});
}

class InternetConnectionFailure extends Failure {
  const InternetConnectionFailure({super.errorCode, super.errorMessage});
}

class TooManyRequestsFailure extends Failure {
  const TooManyRequestsFailure({super.errorCode, super.errorMessage});
}

class PathSearchFailure extends Failure {
  const PathSearchFailure({super.errorCode, super.errorMessage});
}
