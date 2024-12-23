part of '../../import.dart';

class StatusScreenModel extends Equatable {
  const StatusScreenModel({
    required this.type,
    required this.title,
    required this.message,
    required this.primaryButtonText,
    required this.nextRoute,
    this.secondaryButtonText,
    this.nextRouteParams,
    this.autoNavigateAfter,
    this.showCloseButton = true,
    this.additionalActions,
    this.customContent,
  });
  final StatusType type;
  final String title;
  final String message;
  final String primaryButtonText;
  final String nextRoute;
  final String? secondaryButtonText;
  final Map<String, dynamic>? nextRouteParams;
  final Duration? autoNavigateAfter;
  final bool showCloseButton;
  final List<StatusAction>? additionalActions;
  final Widget? customContent;

  @override
  List<Object?> get props => [
        type,
        title,
        message,
        primaryButtonText,
        nextRoute,
        secondaryButtonText,
        nextRouteParams,
        autoNavigateAfter,
        showCloseButton,
        additionalActions,
        customContent,
      ];

  StatusScreenModel copyWith({
    StatusType? type,
    String? title,
    String? message,
    String? primaryButtonText,
    String? nextRoute,
    String? secondaryButtonText,
    Map<String, dynamic>? nextRouteParams,
    Duration? autoNavigateAfter,
    bool? showCloseButton,
    List<StatusAction>? additionalActions,
    Widget? customContent,
  }) {
    return StatusScreenModel(
      type: type ?? this.type,
      title: title ?? this.title,
      message: message ?? this.message,
      primaryButtonText: primaryButtonText ?? this.primaryButtonText,
      nextRoute: nextRoute ?? this.nextRoute,
      secondaryButtonText: secondaryButtonText ?? this.secondaryButtonText,
      nextRouteParams: nextRouteParams ?? this.nextRouteParams,
      autoNavigateAfter: autoNavigateAfter ?? this.autoNavigateAfter,
      showCloseButton: showCloseButton ?? this.showCloseButton,
      additionalActions: additionalActions ?? this.additionalActions,
      customContent: customContent ?? this.customContent,
    );
  }
}
