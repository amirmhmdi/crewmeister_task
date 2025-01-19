import 'package:crewmeister_task/core/services/locator.dart';
import 'package:crewmeister_task/core/services/theme_config.dart';
import 'package:crewmeister_task/features/absents/presentation/blocs/absence_bloc/absence_bloc.dart';
import 'package:crewmeister_task/features/absents/presentation/pages/absence_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  ThemeData themeData = await themeConfing();
  runApp(MyApp(themeData: themeData));
}

class MyApp extends StatelessWidget {
  final ThemeData themeData;
  const MyApp({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<AbsenceBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Crew Meister',
        theme: themeData,
        home: const AbsenceListScreen(),
      ),
    );
  }
}
