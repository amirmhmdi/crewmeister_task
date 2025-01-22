import 'dart:io';

import 'package:crewmeister_task/features/absents/data/datasources/absence_datasource.dart';
import 'package:crewmeister_task/features/absents/data/datasources/absence_datasource_impl.dart';
import 'package:crewmeister_task/features/absents/data/repositories/absence_repository_impl.dart';
import 'package:crewmeister_task/features/absents/domain/repositories/absence_repository.dart';
import 'package:crewmeister_task/features/absents/domain/usecases/fetch_absence_list_api_usecase.dart';
import 'package:crewmeister_task/features/absents/domain/usecases/fetch_member_list_api_usecase.dart';
import 'package:crewmeister_task/features/absents/domain/usecases/send_email_with_ics_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:crewmeister_task/features/absents/presentation/blocs/absence_bloc/absence_bloc.dart';

Future<void> setupGetIt() async {
  GetIt.I.registerSingleton<AbsenceDatasource>(AbsenceDatasourceImpl());
  GetIt.I.registerSingleton<AbsenceRepository>(AbsenceRepositoryImpl(absenceDatasource: GetIt.I<AbsenceDatasource>()));

  GetIt.I.registerSingleton<FetchAbsenceListApiUsecase>(FetchAbsenceListApiUsecase(absenceRepository: GetIt.I<AbsenceRepository>()));
  GetIt.I.registerSingleton<FetchMemberListApiUsecase>(FetchMemberListApiUsecase(absenceRepository: GetIt.I<AbsenceRepository>()));
  GetIt.I.registerSingleton<SendEmailWithICSUsecase>(SendEmailWithICSUsecase(absenceRepository: GetIt.I<AbsenceRepository>()));

  GetIt.I.registerSingleton<AbsenceBloc>(
    AbsenceBloc(
      fetchAbsenceListApiUsecase: GetIt.I<FetchAbsenceListApiUsecase>(),
      fetchMemberListApiUsecase: GetIt.I<FetchMemberListApiUsecase>(),
      sendEmailWithICSUsecase: GetIt.I<SendEmailWithICSUsecase>(),
      isSinglePageApproch: kIsWeb
          ? true
          : (Platform.isAndroid || Platform.isIOS)
              ? false
              : true,
    ),
  );
}
