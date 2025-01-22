import 'package:crewmeister_task/features/absents/presentation/blocs/absence_bloc/absence_bloc.dart';
import 'package:crewmeister_task/features/absents/presentation/widgets/abcence_pageview_indicator_widget.dart';
import 'package:crewmeister_task/features/absents/presentation/widgets/abcence_table_widget.dart';
import 'package:crewmeister_task/features/absents/presentation/widgets/absence_dialog_filter.dart';
import 'package:crewmeister_task/features/absents/presentation/widgets/absence_failur_widget.dart';
import 'package:crewmeister_task/features/absents/presentation/widgets/absence_loading_widget.dart';
import 'package:crewmeister_task/features/absents/presentation/widgets/bottom_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AbsenceListNotMobileScreen extends StatefulWidget {
  const AbsenceListNotMobileScreen({super.key});

  @override
  State<AbsenceListNotMobileScreen> createState() => _AbsenceListNotMobileScreenState();
}

class _AbsenceListNotMobileScreenState extends State<AbsenceListNotMobileScreen> {
  @override
  void initState() {
    GetIt.I<AbsenceBloc>().add(AbsenceListFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Absence List',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CustomDialog(),
              );
            },
            icon: Icon(Icons.filter_alt_rounded),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: BotomAppbarWidget(),
        ),
      ),
      body: BlocBuilder<AbsenceBloc, AbsenceState>(
        buildWhen: (previous, current) {
          if (previous is AbsenceLoadingState && current is AbsenceLoadingState) {
            return false;
          } else if (current is AbsenceEmailSentStatusState) {
            return false;
          } else {
            return true;
          }
        },
        builder: (context, state) {
          if (state is AbsenceLoadingState) {
            return AbsenceLoadingWidget();
          } else if (state is AbsenceloadedState) {
            if (state.absenceList.isEmpty) {
              return Center(
                child: Text(
                  'There is no Record',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            }
            return ListView(
              children: [
                AbsencesTabelWidget(absencesList: state.absenceList),
                PageViewIndicatorWidget(),
              ],
            );
          } else if (state is AbsenceFailurState) {
            return AbsenceFailurWidget(errorMessage: state.errorMessage);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
