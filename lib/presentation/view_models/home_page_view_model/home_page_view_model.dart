import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';
import 'package:shortway/core/error/failure.dart';
import 'package:shortway/domain/entities/field.dart';
import 'package:shortway/domain/repositories/field_brain_repository.dart';

part 'home_page_view_model.g.dart';

class HomePageViewModel = HomePageViewModelBase with _$HomePageViewModel;

abstract class HomePageViewModelBase with Store {
  final FieldBrainRepository _fieldBrainRepository;

  HomePageViewModelBase({
    required FieldBrainRepository fieldBrainRepository,
  }) : _fieldBrainRepository = fieldBrainRepository;

  @observable
  ObservableFuture<Either<Failure, List<Field>>> fetchFieldsResponse =
      ObservableFuture.value(const Right<Failure, List<Field>>([]));

  @action
  Future<bool> tryToFetchFields({required String url}) async {
    fetchFieldsResponse = ObservableFuture(
      _fieldBrainRepository.fetchFieldsFrom(url: url),
    );

    return (await fetchFieldsResponse).fold(
      (failure) => false,
      (result) => true,
    );
  }
}
