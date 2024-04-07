import 'package:mobx/mobx.dart';
import 'package:shortway/domain/entities/field.dart';
import 'package:shortway/domain/entities/field_point.dart';
import 'package:shortway/domain/entities/shortest_path.dart';
import 'package:shortway/domain/repositories/field_brain_repository.dart';
import 'package:shortway/domain/repositories/path_finder_repository.dart';

part 'path_preview_page_view_model.g.dart';

class PathPreviewPageViewModel = PathPreviewPageViewModelBase
    with _$PathPreviewPageViewModel;

abstract class PathPreviewPageViewModelBase with Store {
  final FieldBrainRepository _fieldBrainRepository;
  final PathFinderRepository _pathFinderRepository;

  @observable
  Field? _field;

  @observable
  ShortestPath? _path;

  @computed
  Field? get field => _field;

  @computed
  ShortestPath? get path => _path;

  @computed
  List<List<FieldPoint>>? get points => _field?.fieldPoints;

  PathPreviewPageViewModelBase({
    required FieldBrainRepository fieldBrainRepository,
    required PathFinderRepository pathFinderRepository,
  })  : _fieldBrainRepository = fieldBrainRepository,
        _pathFinderRepository = pathFinderRepository;

  @action
  void init({required String fieldId}) {
    _field = (_fieldBrainRepository.getFieldBy(id: fieldId)).fold(
      (failure) => null,
      (field) => field,
    );

    _path = (_pathFinderRepository.getShortestPathBy(fieldId: fieldId)).fold(
      (failure) => null,
      (path) => path,
    );
  }
}
