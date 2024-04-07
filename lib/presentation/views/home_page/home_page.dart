import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:shortway/core/util/keybaord_tool.dart';
import 'package:shortway/domain/repositories/field_brain_repository.dart';
import 'package:shortway/presentation/base_widgets/app_bars/base_app_bar.dart';
import 'package:shortway/presentation/base_widgets/bottom_sheets/rx_request_bottom_sheet.dart';
import 'package:shortway/presentation/base_widgets/buttons/filled_action_button.dart';
import 'package:shortway/presentation/base_widgets/loading/rx_loading_overlay.dart';
import 'package:shortway/presentation/view_models/home_page_view_model/home_page_view_model.dart';
import 'package:shortway/router/router.gr.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textFieldController = TextEditingController();
  late final viewModel = HomePageViewModel(
    fieldBrainRepository: Provider.of<FieldBrainRepository>(
      context,
      listen: false,
    ),
  );

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  void tryToFetchFields() async {
    KeyboardTool.hideKeyboard(context);

    final url = textFieldController.text;
    final fetchStatus = viewModel.fetchFieldsResponse.status;
    if (fetchStatus == FutureStatus.pending) return;

    final successFetch = await viewModel.tryToFetchFields(
      url: url,
    );

    if (successFetch && mounted) {
      context.router.navigate(ProcessingSearchRoute(url: url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return RxRequestBottomSheet(
      primaryActionText: "Ok",
      isDismissible: true,
      child: RxLoadingOverlay(
        observableFuture: () => viewModel.fetchFieldsResponse,
        child: KeyboardDismissOnTap(
          child: Scaffold(
            appBar: const BaseAppBar(
              titleText: "Home screen",
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Set valid API base URL in order to continue",
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            const Icon(
                              Icons.compare_arrows_outlined,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: TextField(
                                controller: textFieldController,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    FilledActionButton(
                      text: "Start counting process",
                      isActive: true,
                      onPressed: tryToFetchFields,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
