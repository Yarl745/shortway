import 'package:dio/dio.dart';
import 'package:shortway/core/error/exceptions.dart';
import 'package:shortway/core/error/failure.dart';
import 'package:shortway/core/error/failure_controller.dart';
import 'package:shortway/injection_container.dart';

/// Handles global errors and maps them to failure objects.
///
/// This function is the public interface for error handling within the app. It
/// takes an error object and an optional default failure, processes the error,
/// and returns a corresponding failure. It also logs the failure for global
/// state management.
Failure handleError(Object error, {Failure? defaultFailure}) {
  // Call the internal error handling function to process the error.
  final failure = _handleError(error, defaultFailure);

  // Use the service locator to find the FailureController and set the new failure.
  sl<FailureController>().setNewFailure(failure);

  // Return the processed failure to the caller.
  return failure;
}

/// Internal function to process and map errors to failures.
///
/// This function takes an error object and an optional default failure. It
/// checks the type of the error and maps it to a specific failure type if
/// recognized. Otherwise, it returns a generic Failure or the provided default.
Failure _handleError(Object error, [Failure? defaultFailure]) {
  try {
    if (error is SerializationException) {
      return NotCorrectUrlFailure(errorMessage: error.toString());
    } else if (error is NotCorrectUrlException) {
      return NotCorrectUrlFailure(errorMessage: error.toString());
    } else if (error is NoPathException) {
      return PathSearchFailure(errorMessage: error.toString());
    }

    if (error is DioException && error.response != null) {
      final errMsg = error.response?.data.toString();

      if (error.response!.statusCode == 429) {
        return TooManyRequestsFailure(errorMessage: errMsg);
      } else if (error.response!.statusCode == 500 ||
          error.response!.statusCode == 502) {
        return ServerFailure(errorMessage: errMsg);
      }
      return Failure(errorMessage: errMsg);
    }

    // Map unknown Dio exceptions to ServerFailure.
    if (error is DioException && error.type == DioExceptionType.unknown) {
      return const ServerFailure();
    }

    // Return the default failure or a generic Failure if no specific error is recognized.
    return defaultFailure ?? Failure(errorMessage: error.toString());
  } catch (err) {
    // Return a generic Failure if an error occurs during error handling.
    return Failure(errorMessage: err.toString());
  }
}
