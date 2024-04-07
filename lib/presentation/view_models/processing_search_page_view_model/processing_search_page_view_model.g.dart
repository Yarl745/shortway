// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'processing_search_page_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProcessingSearchPageViewModel
    on ProcessingSearchPageViewModelBase, Store {
  Computed<bool>? _$searchFinishedSuccessfullyComputed;

  @override
  bool get searchFinishedSuccessfully =>
      (_$searchFinishedSuccessfullyComputed ??= Computed<bool>(
              () => super.searchFinishedSuccessfully,
              name:
                  'ProcessingSearchPageViewModelBase.searchFinishedSuccessfully'))
          .value;
  Computed<double>? _$processingSearchProgressComputed;

  @override
  double get processingSearchProgress => (_$processingSearchProgressComputed ??=
          Computed<double>(() => super.processingSearchProgress,
              name:
                  'ProcessingSearchPageViewModelBase.processingSearchProgress'))
      .value;
  Computed<bool?>? _$hasPathSearchFailureComputed;

  @override
  bool? get hasPathSearchFailure => (_$hasPathSearchFailureComputed ??=
          Computed<bool?>(() => super.hasPathSearchFailure,
              name: 'ProcessingSearchPageViewModelBase.hasPathSearchFailure'))
      .value;
  Computed<bool>? _$showSendResultButtonComputed;

  @override
  bool get showSendResultButton => (_$showSendResultButtonComputed ??=
          Computed<bool>(() => super.showSendResultButton,
              name: 'ProcessingSearchPageViewModelBase.showSendResultButton'))
      .value;
  Computed<bool>? _$showLoadingComputed;

  @override
  bool get showLoading =>
      (_$showLoadingComputed ??= Computed<bool>(() => super.showLoading,
              name: 'ProcessingSearchPageViewModelBase.showLoading'))
          .value;
  Computed<String>? _$helpTextComputed;

  @override
  String get helpText =>
      (_$helpTextComputed ??= Computed<String>(() => super.helpText,
              name: 'ProcessingSearchPageViewModelBase.helpText'))
          .value;
  Computed<bool>? _$isCheckButtonActiveComputed;

  @override
  bool get isCheckButtonActive => (_$isCheckButtonActiveComputed ??=
          Computed<bool>(() => super.isCheckButtonActive,
              name: 'ProcessingSearchPageViewModelBase.isCheckButtonActive'))
      .value;

  late final _$processingWidgetPercentAtom = Atom(
      name: 'ProcessingSearchPageViewModelBase.processingWidgetPercent',
      context: context);

  @override
  int? get processingWidgetPercent {
    _$processingWidgetPercentAtom.reportRead();
    return super.processingWidgetPercent;
  }

  @override
  set processingWidgetPercent(int? value) {
    _$processingWidgetPercentAtom
        .reportWrite(value, super.processingWidgetPercent, () {
      super.processingWidgetPercent = value;
    });
  }

  late final _$_processingSearchProgressAtom = Atom(
      name: 'ProcessingSearchPageViewModelBase._processingSearchProgress',
      context: context);

  @override
  double get _processingSearchProgress {
    _$_processingSearchProgressAtom.reportRead();
    return super._processingSearchProgress;
  }

  @override
  set _processingSearchProgress(double value) {
    _$_processingSearchProgressAtom
        .reportWrite(value, super._processingSearchProgress, () {
      super._processingSearchProgress = value;
    });
  }

  late final _$_hasPathSearchFailureAtom = Atom(
      name: 'ProcessingSearchPageViewModelBase._hasPathSearchFailure',
      context: context);

  @override
  bool? get _hasPathSearchFailure {
    _$_hasPathSearchFailureAtom.reportRead();
    return super._hasPathSearchFailure;
  }

  @override
  set _hasPathSearchFailure(bool? value) {
    _$_hasPathSearchFailureAtom.reportWrite(value, super._hasPathSearchFailure,
        () {
      super._hasPathSearchFailure = value;
    });
  }

  late final _$checkPathsResponseAtom = Atom(
      name: 'ProcessingSearchPageViewModelBase.checkPathsResponse',
      context: context);

  @override
  ObservableFuture<Either<Failure, bool>> get checkPathsResponse {
    _$checkPathsResponseAtom.reportRead();
    return super.checkPathsResponse;
  }

  @override
  set checkPathsResponse(ObservableFuture<Either<Failure, bool>> value) {
    _$checkPathsResponseAtom.reportWrite(value, super.checkPathsResponse, () {
      super.checkPathsResponse = value;
    });
  }

  late final _$tryToSearchingPathsAsyncAction = AsyncAction(
      'ProcessingSearchPageViewModelBase.tryToSearchingPaths',
      context: context);

  @override
  Future<bool> tryToSearchingPaths() {
    return _$tryToSearchingPathsAsyncAction
        .run(() => super.tryToSearchingPaths());
  }

  late final _$tryToCheckPathsAsyncAction = AsyncAction(
      'ProcessingSearchPageViewModelBase.tryToCheckPaths',
      context: context);

  @override
  Future<bool> tryToCheckPaths({required String url}) {
    return _$tryToCheckPathsAsyncAction
        .run(() => super.tryToCheckPaths(url: url));
  }

  @override
  String toString() {
    return '''
processingWidgetPercent: ${processingWidgetPercent},
checkPathsResponse: ${checkPathsResponse},
searchFinishedSuccessfully: ${searchFinishedSuccessfully},
processingSearchProgress: ${processingSearchProgress},
hasPathSearchFailure: ${hasPathSearchFailure},
showSendResultButton: ${showSendResultButton},
showLoading: ${showLoading},
helpText: ${helpText},
isCheckButtonActive: ${isCheckButtonActive}
    ''';
  }
}
