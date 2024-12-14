part of '../../import.dart';

class StatusView extends StatefulWidget {
  const StatusView({
    required this.config,
    super.key,
  });

  final StatusScreenModel config;

  @override
  State<StatusView> createState() => _StatusViewState();
}

class _StatusViewState extends State<StatusView> {
  late final StatusViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = StatusViewModel();
    _setupAutoNavigation();
    _logAnalytics();
  }

  void _setupAutoNavigation() {
    if (widget.config.autoNavigateAfter != null) {
      _viewModel.setupAutoNavigation(
        widget.config.autoNavigateAfter!,
        _handlePrimaryButtonPress,
      );
    }
  }

  void _logAnalytics() {
  //  StatusAnalytics.logStatusScreenView(widget.config);
  }

  void _handlePrimaryButtonPress() {
  //  StatusAnalytics.logStatusAction('primary_button', widget.config);
    if (widget.config.nextRouteParams != null) {
      context.pushNamed(
        widget.config.nextRoute,
        extra: widget.config.nextRouteParams,
      );
    } else {
      context.go(widget.config.nextRoute);
    }
  }

  void _handleSecondaryButtonPress() {
  //  StatusAnalytics.logStatusAction('secondary_button', widget.config);
    context.pop();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => _viewModel.canPop,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.config.showCloseButton)
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: _handleSecondaryButtonPress,
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStatusIcon(),
                      const SizedBox(height: 24),
                      Text(
                        widget.config.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.config.message,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      if (widget.config.customContent != null) ...[
                        const SizedBox(height: 24),
                        widget.config.customContent!,
                      ],
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: _handlePrimaryButtonPress,
                        child: Text(widget.config.primaryButtonText),
                      ),
                      if (widget.config.secondaryButtonText != null) ...[
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: _handleSecondaryButtonPress,
                          child: Text(widget.config.secondaryButtonText!),
                        ),
                      ],
                      if (widget.config.additionalActions != null) ...[
                        const SizedBox(height: 16),
                        ..._buildAdditionalActions(),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon() {
    final theme = statusThemes[widget.config.type]!;

    if (theme.animationAsset != null) {
      return Lottie.asset(
        theme.animationAsset!,
        width: 120,
        height: 120,
      );
    }

    return Icon(
      theme.icon,
      size: 80,
      color: theme.color,
    );
  }

  List<Widget> _buildAdditionalActions() {
    return widget.config.additionalActions!.map((action) {
      return TextButton(
        onPressed: () {
        //  StatusAnalytics.logStatusAction('additional_action', widget.config);
          action.onPressed();
        },
        style: TextButton.styleFrom(
          foregroundColor: action.textColor,
          backgroundColor: action.backgroundColor,
        ),
        child: Text(action.label),
      );
    }).toList();
  }
}
