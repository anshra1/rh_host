// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// ignore: depend_on_referenced_packages
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:rh_host/src/core/clock/clock_provider.dart';
import 'package:rh_host/src/core/clock/time_config.dart';
import 'package:rh_host/src/core/error/errror_system/error_handler.dart';
import 'package:rh_host/src/core/network/network_info.dart';
import 'package:rh_host/src/core/storage/app_storage.dart';
import 'package:rh_host/src/core/storage/shared_pref_storage.dart';
import 'package:rh_host/src/features/passcode/data/repo/data_source_repo.dart';
import 'package:rh_host/src/features/passcode/data/sources/passcode_remote_data_source.dart';
import 'package:rh_host/src/features/passcode/domain/repositories/passcode_repo.dart';
import 'package:rh_host/src/features/passcode/domain/usecases/enable_disable_passcode.dart';
import 'package:rh_host/src/features/passcode/domain/usecases/set_new_passcode.dart';
import 'package:rh_host/src/features/passcode/domain/usecases/should_show_passcode.dart';
import 'package:rh_host/src/features/passcode/domain/usecases/verify_passcode.dart';
import 'package:rh_host/src/features/passcode/presentation/bloc/passcode_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'injection_container_main.dart';
