import 'package:mobx/mobx.dart';
import 'package:shortway/core/error/failure.dart';

part 'failure_controller.g.dart';

/// Defines a store for managing failure states across the application.
///
/// This class is a MobX store that holds the current failure state, allowing
/// components to react to changes in this state. It provides actions to set a
/// new failure or reset the current failure.
class FailureController = FailureControllerBase with _$FailureController;

abstract class FailureControllerBase with Store {
  /// Holds the current failure state of the application.
  ///
  /// This observable property allows MobX to track changes to the current failure,
  /// triggering reactions whenever it is updated.
  @observable
  Failure? currentFailure;

  /// Sets a new failure state.
  @action
  void setNewFailure(Failure? failure) {
    currentFailure = failure;
  }

  /// Resets the failure state to null.
  @action
  void resetFailure() {
    currentFailure = null;
  }
}
