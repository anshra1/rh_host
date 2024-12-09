// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:rh_host/src/core/enum/alert_type.dart';
import 'package:rh_host/src/core/extension/center.dart';
import 'package:rh_host/src/core/extension/context.dart';
import 'package:rh_host/src/core/extension/double.dart';
import 'package:rh_host/src/core/extension/padding.dart';
import 'package:rh_host/src/core/extension/text_style_extension.dart';
// Project imports:
import 'package:rh_host/src/core/presentation/constants/colors.dart';
import 'package:rh_host/src/core/presentation/constants/font.dart';
import 'package:rh_host/src/core/presentation/constants/spacing.dart';
import 'package:rh_host/src/core/presentation/constants/string.dart';
import 'package:rh_host/src/core/presentation/widgets/appbar/app_bar.dart';
import 'package:rh_host/src/core/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:rh_host/src/core/presentation/widgets/input/label_input_field.dart';
import 'package:rh_host/src/core/system/alert_system/alert.dart';
import 'package:rh_host/src/core/system/alert_system/alert_manager.dart';
import 'package:rh_host/src/core/system/failure/failure_manager.dart';
import 'package:rh_host/src/core/system/loading/loading_controller.dart';
import 'package:rh_host/src/core/system/logger/debug_logger.dart';
import 'package:rh_host/src/core/utils/formatter/input_formatter.dart';
import 'package:rh_host/src/features/batch/import.dart';
import 'package:rh_host/src/features/passcode/presentation/bloc/passcode_cubit.dart';
import 'package:rh_host/src/features/passcode/presentation/bloc/passcode_state.dart';
import 'package:rh_host/src/features/passcode/presentation/pages/passcode_page/utils/passcode_validator.dart';
import 'package:rh_host/src/features/passcode/presentation/pages/passcode_page/view/passcode_input_view.dart';

part 'presentation/pages/passcode_page/passode_page.dart';
part 'presentation/pages/passcode_page/view/passcode_header_view.dart';
part 'presentation/pages/passcode_page/view/passcode_keypad_view.dart';
part 'presentation/pages/passcode_page/view/passcode_view.dart';
part 'presentation/pages/reset_page/reset_pin_page.dart';
part 'presentation/pages/reset_page/views/reset_page_view.dart';
