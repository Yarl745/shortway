// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'path_preview_page_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PathPreviewPageViewModel on PathPreviewPageViewModelBase, Store {
  Computed<Field?>? _$fieldComputed;

  @override
  Field? get field => (_$fieldComputed ??= Computed<Field?>(() => super.field,
          name: 'PathPreviewPageViewModelBase.field'))
      .value;
  Computed<ShortestPath?>? _$pathComputed;

  @override
  ShortestPath? get path =>
      (_$pathComputed ??= Computed<ShortestPath?>(() => super.path,
              name: 'PathPreviewPageViewModelBase.path'))
          .value;
  Computed<List<List<FieldPoint>>?>? _$pointsComputed;

  @override
  List<List<FieldPoint>>? get points => (_$pointsComputed ??=
          Computed<List<List<FieldPoint>>?>(() => super.points,
              name: 'PathPreviewPageViewModelBase.points'))
      .value;

  late final _$_fieldAtom =
      Atom(name: 'PathPreviewPageViewModelBase._field', context: context);

  @override
  Field? get _field {
    _$_fieldAtom.reportRead();
    return super._field;
  }

  @override
  set _field(Field? value) {
    _$_fieldAtom.reportWrite(value, super._field, () {
      super._field = value;
    });
  }

  late final _$_pathAtom =
      Atom(name: 'PathPreviewPageViewModelBase._path', context: context);

  @override
  ShortestPath? get _path {
    _$_pathAtom.reportRead();
    return super._path;
  }

  @override
  set _path(ShortestPath? value) {
    _$_pathAtom.reportWrite(value, super._path, () {
      super._path = value;
    });
  }

  late final _$PathPreviewPageViewModelBaseActionController =
      ActionController(name: 'PathPreviewPageViewModelBase', context: context);

  @override
  void init({required String fieldId}) {
    final _$actionInfo = _$PathPreviewPageViewModelBaseActionController
        .startAction(name: 'PathPreviewPageViewModelBase.init');
    try {
      return super.init(fieldId: fieldId);
    } finally {
      _$PathPreviewPageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
field: ${field},
path: ${path},
points: ${points}
    ''';
  }
}
