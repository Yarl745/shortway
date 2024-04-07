import 'package:mobx/mobx.dart';
import 'package:shortway/domain/entities/shortest_path.dart';
import 'package:shortway/domain/repositories/path_finder_repository.dart';

part 'found_paths_page_view_model.g.dart';

class FoundPathsPageViewModel = FoundPathsPageViewModelBase
    with _$FoundPathsPageViewModel;

abstract class FoundPathsPageViewModelBase with Store {
  final PathFinderRepository _pathFinderRepository;

  @observable
  List<ShortestPath> _shortestPaths = [];

  @computed
  List<ShortestPath> get shortestPaths => _shortestPaths;

  FoundPathsPageViewModelBase({
    required PathFinderRepository pathFinderRepository,
  }) : _pathFinderRepository = pathFinderRepository;

  @action
  void init() {
    _shortestPaths = _pathFinderRepository.getFoundShortestPaths();
  }
}
