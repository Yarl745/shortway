// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:shortway/presentation/views/found_paths_page/found_paths_page.dart'
    as _i1;
import 'package:shortway/presentation/views/home_page/home_page.dart' as _i2;
import 'package:shortway/presentation/views/path_preview_page/path_preview_page.dart'
    as _i3;
import 'package:shortway/presentation/views/processing_search_page/processing_search_page.dart'
    as _i4;
import 'package:shortway/presentation/views/provider_wrapper_page/provider_wrapper_page.dart'
    as _i5;
import 'package:shortway/presentation/views/root_page/root_page.dart' as _i6;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    FoundPathsRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.FoundPathsPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    PathPreviewRoute.name: (routeData) {
      final args = routeData.argsAs<PathPreviewRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.PathPreviewPage(
          key: args.key,
          selectedFieldId: args.selectedFieldId,
        ),
      );
    },
    ProcessingSearchRoute.name: (routeData) {
      final args = routeData.argsAs<ProcessingSearchRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.ProcessingSearchPage(
          key: args.key,
          url: args.url,
        ),
      );
    },
    ProviderWrapperRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.WrappedRoute(child: const _i5.ProviderWrapperPage()),
      );
    },
    RootRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.RootPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.FoundPathsPage]
class FoundPathsRoute extends _i7.PageRouteInfo<void> {
  const FoundPathsRoute({List<_i7.PageRouteInfo>? children})
      : super(
          FoundPathsRoute.name,
          initialChildren: children,
        );

  static const String name = 'FoundPathsRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.PathPreviewPage]
class PathPreviewRoute extends _i7.PageRouteInfo<PathPreviewRouteArgs> {
  PathPreviewRoute({
    _i8.Key? key,
    required String selectedFieldId,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          PathPreviewRoute.name,
          args: PathPreviewRouteArgs(
            key: key,
            selectedFieldId: selectedFieldId,
          ),
          initialChildren: children,
        );

  static const String name = 'PathPreviewRoute';

  static const _i7.PageInfo<PathPreviewRouteArgs> page =
      _i7.PageInfo<PathPreviewRouteArgs>(name);
}

class PathPreviewRouteArgs {
  const PathPreviewRouteArgs({
    this.key,
    required this.selectedFieldId,
  });

  final _i8.Key? key;

  final String selectedFieldId;

  @override
  String toString() {
    return 'PathPreviewRouteArgs{key: $key, selectedFieldId: $selectedFieldId}';
  }
}

/// generated route for
/// [_i4.ProcessingSearchPage]
class ProcessingSearchRoute
    extends _i7.PageRouteInfo<ProcessingSearchRouteArgs> {
  ProcessingSearchRoute({
    _i8.Key? key,
    required String url,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          ProcessingSearchRoute.name,
          args: ProcessingSearchRouteArgs(
            key: key,
            url: url,
          ),
          initialChildren: children,
        );

  static const String name = 'ProcessingSearchRoute';

  static const _i7.PageInfo<ProcessingSearchRouteArgs> page =
      _i7.PageInfo<ProcessingSearchRouteArgs>(name);
}

class ProcessingSearchRouteArgs {
  const ProcessingSearchRouteArgs({
    this.key,
    required this.url,
  });

  final _i8.Key? key;

  final String url;

  @override
  String toString() {
    return 'ProcessingSearchRouteArgs{key: $key, url: $url}';
  }
}

/// generated route for
/// [_i5.ProviderWrapperPage]
class ProviderWrapperRoute extends _i7.PageRouteInfo<void> {
  const ProviderWrapperRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ProviderWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProviderWrapperRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.RootPage]
class RootRoute extends _i7.PageRouteInfo<void> {
  const RootRoute({List<_i7.PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
