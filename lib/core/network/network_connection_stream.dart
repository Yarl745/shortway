import 'dart:async';

import 'package:rxdart/subjects.dart';

/// Manages the network connection status stream and listeners.
///
/// This class encapsulates the handling of network connection status, providing
/// a stream that emits connection status updates. It allows for registration and
/// deregistration of listeners that react to these changes.
class NetworkConnectionStream {
  /// Controller for the network connection status stream.
  final StreamController<bool> _networkStreamController =
      BehaviorSubject<bool>();

  /// A list of functions that will be called when the network connection status changes.
  final List<Function(bool)> _networkConnectionListeners = [];

  late final StreamSubscription _networkStreamSubscription;

  /// Tracks the current network connection status.
  bool isConnected = true;

  bool _isListening = true;

  Stream<bool> get networkStream => _networkStreamController.stream;

  /// Initializes the stream subscription to handle connection status updates.
  void init() {
    _networkStreamSubscription = networkStream.listen(
      (isConnected) {
        // Notify all registered listeners of the connection status change.
        for (final listener in _networkConnectionListeners) {
          listener(isConnected);
        }
      },
    );
  }

  /// Adds a new listener to be notified of connection status changes.
  void addListener(Function(bool) listener) =>
      _networkConnectionListeners.add(listener);

  /// Removes a previously registered listener.
  void removeListener(Function(bool) listener) =>
      _networkConnectionListeners.remove(listener);

  /// Clears all registered listeners.
  void clearAllListeners() => _networkConnectionListeners.clear();

  /// Resumes notifying listeners of connection status changes.
  void startListen() => _isListening = true;

  /// Pauses notifying listeners of connection status changes.
  void stopListen() => _isListening = false;

  /// Updates the connection status and notifies listeners if there's a change.
  ///
  /// This method updates the internal connection status and, if there is a change and
  /// the stream is set to notify listeners, emits the new status to the stream.
  void setConnectionStatus(bool isConnected) {
    if ((isConnected == false || this.isConnected != isConnected) &&
        _isListening) {
      this.isConnected = isConnected;
      _networkStreamController.sink.add(isConnected);
    }
  }

  /// Disposes of the stream and its subscription.
  void dispose() {
    _networkStreamSubscription.cancel();
    _networkStreamController.close();
  }
}
