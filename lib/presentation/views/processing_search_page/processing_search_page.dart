import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:shortway/domain/repositories/field_brain_repository.dart';
import 'package:shortway/domain/repositories/path_finder_repository.dart';
import 'package:shortway/presentation/base_widgets/app_bars/base_app_bar.dart';
import 'package:shortway/presentation/base_widgets/bottom_sheets/rx_request_bottom_sheet.dart';
import 'package:shortway/presentation/base_widgets/buttons/filled_action_button.dart';
import 'package:shortway/presentation/base_widgets/loading/rx_loading_overlay.dart';
import 'package:shortway/presentation/view_models/processing_search_page_view_model/processing_search_page_view_model.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

@RoutePage()
class ProcessingSearchPage extends StatefulWidget {
  final String url;

  const ProcessingSearchPage({super.key, required this.url});

  @override
  State<ProcessingSearchPage> createState() => _ProcessingSearchPageState();
}

class _ProcessingSearchPageState extends State<ProcessingSearchPage> {
  late final viewModel = ProcessingSearchPageViewModel(
    fieldBrainRepository:
        Provider.of<FieldBrainRepository>(context, listen: false),
    pathFinderRepository:
        Provider.of<PathFinderRepository>(context, listen: false),
  );
  late ValueNotifier<double> valueNotifier;
  late final ReactionDisposer progressListenerDisposer;

  @override
  void initState() {
    super.initState();
    valueNotifier = ValueNotifier(0.0);
    progressListenerDisposer = reaction(
      (_) => viewModel.processingSearchProgress,
      (progress) {
        valueNotifier.value = progress;
      },
    );
    viewModel.tryToSearchingPaths();
  }

  @override
  void dispose() {
    progressListenerDisposer();
    valueNotifier.dispose();
    super.dispose();
  }

  void tryToCheckFoundPaths() async {
    final isPathsCorrect = await viewModel.tryToCheckPaths(url: widget.url);

    if (isPathsCorrect && mounted) {
      context.router.navigateNamed('found-paths');
    }
  }

  @override
  Widget build(BuildContext context) {
    return RxRequestBottomSheet(
      primaryActionText: "Ok",
      child: RxLoadingOverlay(
        observableFuture: () => viewModel.checkPathsResponse,
        child: Scaffold(
          appBar: const BaseAppBar(
            titleText: "Process screen",
            withBackButton: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Observer(builder: (context) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              viewModel.helpText,
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Visibility(
                              visible: viewModel.showLoading,
                              child: Text(
                                "${viewModel.processingWidgetPercent ?? 0}%",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        );
                      }),
                      const Divider(),
                      Observer(builder: (context) {
                        return Visibility(
                          visible: viewModel.showLoading &&
                              viewModel.processingWidgetPercent != 100,
                          child: SimpleCircularProgressBar(
                            size: 100,
                            valueNotifier: valueNotifier,
                            progressStrokeWidth: 4,
                            backStrokeWidth: 4,
                            mergeMode: true,
                            onGetText: (value) {
                              viewModel.processingWidgetPercent = value.toInt();
                              return const Text('');
                            },
                            progressColors: const [Colors.blue],
                            backColor: Colors.transparent,
                          ),
                        );
                      }),
                    ],
                  ),
                  const Spacer(),
                  Observer(builder: (context) {
                    return Visibility(
                      visible: viewModel.searchFinishedSuccessfully,
                      replacement: const SizedBox(height: 48),
                      child: FilledActionButton(
                        text: "Send results to server",
                        isActive: viewModel.isCheckButtonActive,
                        onPressed: tryToCheckFoundPaths,
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
