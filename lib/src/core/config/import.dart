// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:get_it/get_it.dart';
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