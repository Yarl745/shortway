// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failure_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FailureController on FailureControllerBase, Store {
  late final _$currentFailureAtom =
      Atom(name: 'FailureControllerBase.currentFailure', context: context);

  @override
  Failure? get currentFailure {
    _$currentFailureAtom.reportRead();
    return super.currentFailure;
  }

  @override
  set currentFailure(Failure? value) {
    _$currentFailureAtom.reportWrite(value, super.currentFailure, () {
      super.currentFailure = value;
    });
  }

  late final _$FailureControllerBaseActionController =
      ActionController(name: 'FailureControllerBase', context: context);

  @override
  void setNewFailure(Failure? failure) {
    final _$actionInfo = _$FailureControllerBaseActionController.startAction(
        name: 'FailureControllerBase.setNewFailure');
    try {
      return super.setNewFailure(failure);
    } finally {
      _$FailureControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetFailure() {
    final _$actionInfo = _$FailureControllerBaseActionController.startAction(
        name: 'FailureControllerBase.resetFailure');
    try {
      return super.resetFailure();
    } finally {
      _$FailureControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentFailure: ${currentFailure}
    ''';
  }
}
