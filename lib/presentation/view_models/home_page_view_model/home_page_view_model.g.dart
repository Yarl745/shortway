// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomePageViewModel on HomePageViewModelBase, Store {
  late final _$fetchFieldsResponseAtom =
      Atom(name: 'HomePageViewModelBase.fetchFieldsResponse', context: context);

  @override
  ObservableFuture<Either<Failure, List<Field>>> get fetchFieldsResponse {
    _$fetchFieldsResponseAtom.reportRead();
    return super.fetchFieldsResponse;
  }

  @override
  set fetchFieldsResponse(
      ObservableFuture<Either<Failure, List<Field>>> value) {
    _$fetchFieldsResponseAtom.reportWrite(value, super.fetchFieldsResponse, () {
      super.fetchFieldsResponse = value;
    });
  }

  late final _$tryToFetchFieldsAsyncAction =
      AsyncAction('HomePageViewModelBase.tryToFetchFields', context: context);

  @override
  Future<bool> tryToFetchFields({required String url}) {
    return _$tryToFetchFieldsAsyncAction
        .run(() => super.tryToFetchFields(url: url));
  }

  @override
  String toString() {
    return '''
fetchFieldsResponse: ${fetchFieldsResponse}
    ''';
  }
}
