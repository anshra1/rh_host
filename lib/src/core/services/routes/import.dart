// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:rh_host/src/core/page/fallback_page/page_under_construction.dart';
import 'package:rh_host/src/core/page/import.dart';
import 'package:rh_host/src/core/page/status/presentation/status_screen_simple.dart';
import 'package:rh_host/src/core/page/status/presentation/status_screen_with_timer.dart';
import 'package:rh_host/src/core/services/config/import.dart';
import 'package:rh_host/src/features/batch/import.dart';
import 'package:rh_host/src/features/navigation/bottom_navigation.dart';
import 'package:rh_host/src/features/passcode/import.dart';
import 'package:rh_host/src/features/passcode/presentation/bloc/passcode_cubit.dart';
import 'package:rh_host/src/features/services/presentation/pages/pages.dart';

part 'app_router.dart';
part 'app_routes.dart';
