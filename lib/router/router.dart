import 'package:auto_route/auto_route.dart';
import 'package:shortway/router/router.gr.dart';

/// Generate router code
/// dart run build_runner watch --delete-conflicting-outputs
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      path: '/',
      page: RootRoute.page,
      children: [
        RedirectRoute(path: '', redirectTo: 'home'),
        AutoRoute(
          path: 'home',
          page: ProviderWrapperRoute.page,
          children: [
            AutoRoute(path: '', page: HomeRoute.page),
            AutoRoute(path: 'processing', page: ProcessingSearchRoute.page),
            AutoRoute(path: 'found-paths', page: FoundPathsRoute.page),
            AutoRoute(path: 'path-preview', page: PathPreviewRoute.page),
          ],
        ),
      ],
    ),
  ];
}
