import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shortway/domain/entities/shortest_path.dart';
import 'package:shortway/domain/repositories/path_finder_repository.dart';
import 'package:shortway/presentation/base_widgets/app_bars/base_app_bar.dart';
import 'package:shortway/presentation/view_models/found_paths_page_view_model/found_paths_page_view_model.dart';
import 'package:shortway/router/router.gr.dart';

@RoutePage()
class FoundPathsPage extends StatefulWidget {
  const FoundPathsPage({super.key});

  @override
  State<FoundPathsPage> createState() => _FoundPathsPageState();
}

class _FoundPathsPageState extends State<FoundPathsPage> {
  late final viewModel = FoundPathsPageViewModel(
    pathFinderRepository:
        Provider.of<PathFinderRepository>(context, listen: false),
  );

  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        titleText: "Result list screen",
        withBackButton: true,
      ),
      body: SafeArea(
        child: Observer(builder: (context) {
          return ListView.separated(
            itemCount: viewModel.shortestPaths.length,
            itemBuilder: (context, index) {
              final shortestPath = viewModel.shortestPaths[index];
              return _PathListTile(
                path: shortestPath,
                onTap: () {
                  context.router.navigate(
                    PathPreviewRoute(
                      selectedFieldId: shortestPath.fieldId,
                    ),
                  );
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                thickness: 1.5,
              );
            },
          );
        }),
      ),
    );
  }
}

class _PathListTile extends StatelessWidget {
  final ShortestPath path;
  final VoidCallback onTap;

  const _PathListTile({super.key, required this.path, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Visibility(
          visible: path.hasVariants,
          replacement: Text(
            path.path,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          child: Container(
            height: 48,
            width: double.infinity,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
