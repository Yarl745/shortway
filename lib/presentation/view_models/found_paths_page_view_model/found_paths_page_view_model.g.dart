// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'found_paths_page_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FoundPathsPageViewModel on FoundPathsPageViewModelBase, Store {
  Computed<List<ShortestPath>>? _$shortestPathsComputed;

  @override
  List<ShortestPath> get shortestPaths => (_$shortestPathsComputed ??=
          Computed<List<ShortestPath>>(() => super.shortestPaths,
              name: 'FoundPathsPageViewModelBase.shortestPaths'))
      .value;

  late final _$_shortestPathsAtom = Atom(
      name: 'FoundPathsPageViewModelBase._shortestPaths', context: context);

  @override
  List<ShortestPath> get _shortestPaths {
    _$_shortestPathsAtom.reportRead();
    return super._shortestPaths;
  }

  @override
  set _shortestPaths(List<ShortestPath> value) {
    _$_shortestPathsAtom.reportWrite(value, super._shortestPaths, () {
      super._shortestPaths = value;
    });
  }

  late final _$FoundPathsPageViewModelBaseActionController =
      ActionController(name: 'FoundPathsPageViewModelBase', context: context);

  @override
  void init() {
    final _$actionInfo = _$FoundPathsPageViewModelBaseActionController
        .startAction(name: 'FoundPathsPageViewModelBase.init');
    try {
      return super.init();
    } finally {
      _$FoundPathsPageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
shortestPaths: ${shortestPaths}
    ''';
  }
}
