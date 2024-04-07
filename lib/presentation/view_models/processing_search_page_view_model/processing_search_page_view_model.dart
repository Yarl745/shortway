import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';
import 'package:shortway/core/error/failure.dart';
import 'package:shortway/domain/repositories/field_brain_repository.dart';
import 'package:shortway/domain/repositories/path_finder_repository.dart';

part 'processing_search_page_view_model.g.dart';

class ProcessingSearchPageViewModel = ProcessingSearchPageViewModelBase
    with _$ProcessingSearchPageViewModel;

abstract class ProcessingSearchPageViewModelBase with Store {
  final FieldBrainRepository _fieldBrainRepository;
  final PathFinderRepository _pathFinderRepository;

  @observable
  int? processingWidgetPercent = 0;

  @computed
  bool get searchFinishedSuccessfully => processingWidgetPercent == 100;

  @observable
  double _processingSearchProgress = 0;

  @computed
  double get processingSearchProgress => _processingSearchProgress;

  @observable
  bool? _hasPathSearchFailure;

  @computed
  bool? get hasPathSearchFailure => _hasPathSearchFailure;

  @computed
  bool get showSendResultButton => _hasPathSearchFailure == false;

  @computed
  bool get showLoading =>
      _hasPathSearchFailure == null || _hasPathSearchFailure == false;

  @computed
  String get helpText {
    if (processingWidgetPercent != null && processingWidgetPercent! == 100) {
      return "All calculations has finished, "
          "you can send your results to server";
    } else if (_hasPathSearchFailure ?? false) {
      return "An error occurred while searching for paths!";
    }

    return "Searching for paths in the process...";
  }

  ProcessingSearchPageViewModelBase({
    required FieldBrainRepository fieldBrainRepository,
    required PathFinderRepository pathFinderRepository,
  })  : _fieldBrainRepository = fieldBrainRepository,
        _pathFinderRepository = pathFinderRepository;

  @action
  Future<bool> tryToSearchingPaths() async {
    final fields = _fieldBrainRepository.getFetchedFields();
    _pathFinderRepository.clearFoundShortestPaths();

    for (var i = 0; i < fields.length; i++) {
      final failure = _pathFinderRepository.findShortestPathFor(
        field: fields[i],
      );
      await Future.delayed(const Duration(milliseconds: 50));

      if (failure != null) {
        await Future.delayed(const Duration(milliseconds: 500));
        _hasPathSearchFailure = true;
        return false;
      }

      _processingSearchProgress = (i + 1) / fields.length * 100;
    }

    _hasPathSearchFailure = false;
    return true;
  }

  @observable
  ObservableFuture<Either<Failure, bool>> checkPathsResponse =
      ObservableFuture.value(const Right<Failure, bool>(false));

  @computed
  bool get isCheckButtonActive =>
      checkPathsResponse.status != FutureStatus.pending;

  @action
  Future<bool> tryToCheckPaths({required String url}) async {
    checkPathsResponse = ObservableFuture(
      _pathFinderRepository.checkFoundPathsIsCorrect(url: url),
    );

    return (await checkPathsResponse).fold(
      (failure) => false,
      (result) => true,
    );
  }
}
