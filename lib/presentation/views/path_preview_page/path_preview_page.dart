import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortway/domain/entities/coordinate.dart';
import 'package:shortway/domain/repositories/field_brain_repository.dart';
import 'package:shortway/domain/repositories/path_finder_repository.dart';
import 'package:shortway/presentation/base_widgets/app_bars/base_app_bar.dart';
import 'package:shortway/presentation/view_models/path_preview_page_view_model/path_preview_page_view_model.dart';

@RoutePage()
class PathPreviewPage extends StatefulWidget {
  final String selectedFieldId;

  const PathPreviewPage({super.key, required this.selectedFieldId});

  @override
  State<PathPreviewPage> createState() => _PathPreviewPageState();
}

class _PathPreviewPageState extends State<PathPreviewPage> {
  late final viewModel = PathPreviewPageViewModel(
    fieldBrainRepository:
        Provider.of<FieldBrainRepository>(context, listen: false),
    pathFinderRepository:
        Provider.of<PathFinderRepository>(context, listen: false),
  );

  @override
  void initState() {
    super.initState();
    viewModel.init(fieldId: widget.selectedFieldId);
  }

  @override
  Widget build(BuildContext context) {
    if (viewModel.field == null || viewModel.path == null) {
      return const Scaffold(
        appBar: BaseAppBar(
          titleText: "Process screen",
          withBackButton: true,
        ),
      );
    }

    final gridSize = viewModel.points!.length;

    final width = MediaQuery.of(context).size.width;
    final cellWidth = width / gridSize;
    final aspectRatio = cellWidth / cellWidth;

    return Scaffold(
      appBar: const BaseAppBar(
        titleText: "Preview screen",
        withBackButton: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GridView.builder(
              shrinkWrap: true,
              itemCount: gridSize * gridSize,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridSize,
                childAspectRatio: aspectRatio,
              ),
              itemBuilder: (context, index) {
                int row = index ~/ gridSize;
                int col = index % gridSize;

                final fieldPoint = viewModel.points![col][row];

                return _GridCellItem(
                  coord: fieldPoint.coord,
                  isStartPoint:
                      fieldPoint.coord == viewModel.field!.start.coord,
                  isPathPoint: viewModel.path!.steps.contains(fieldPoint.coord),
                  isEndPoint: fieldPoint.coord == viewModel.field!.end.coord,
                  isBlockedPoint: fieldPoint.isBlocked,
                );
              },
            ),
            Text(
              viewModel.path!.path,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridCellItem extends StatelessWidget {
  final bool isStartPoint;
  final bool isEndPoint;
  final bool isPathPoint;
  final bool isBlockedPoint;
  final Coordinate coord;

  const _GridCellItem({
    super.key,
    required this.isStartPoint,
    required this.isEndPoint,
    required this.isPathPoint,
    required this.isBlockedPoint,
    required this.coord,
  });

  Color get cellColor {
    if (isStartPoint) {
      return const Color(0xff64FFDA);
    } else if (isEndPoint) {
      return const Color(0xff009688);
    } else if (isPathPoint) {
      return const Color(0xff4CAF50);
    } else if (isBlockedPoint) {
      return Colors.black;
    }

    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: cellColor,
      ),
      child: Center(
        child: Text(
          '(${coord.x},${coord.y})',
          style: TextStyle(
            color: isBlockedPoint ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
