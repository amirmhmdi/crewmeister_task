import 'package:crewmeister_task/features/absents/presentation/blocs/absence_bloc/absence_bloc.dart';
import 'package:crewmeister_task/features/absents/presentation/widgets/absence_dialog_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class BotomAppbarWidget extends StatelessWidget {
  const BotomAppbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.0,
      child: Column(
        children: [
          Divider(height: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  BlocBuilder<AbsenceBloc, AbsenceState>(
                    builder: (context, state) {
                      if (state is AbsenceloadedState) {
                        return Text(
                          'Total: ${state.totalAbcenceCount}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        );
                      } else if (state is AbsenceFailurState) {
                        return Text(
                          'Total: - ',
                          style: Theme.of(context).textTheme.bodyLarge,
                        );
                      } else {
                        return Row(
                          children: [
                            Text(
                              'Total: ',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 3),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  VerticalDivider(endIndent: 4.0, indent: 4.0),
                  BlocBuilder<AbsenceBloc, AbsenceState>(
                    buildWhen: (previous, current) => (current is AbsenceUpdateFiltersListState || current is AbsenceloadedState),
                    builder: (context, state) {
                      return Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(4.0),
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => CustomDialog(),
                                );
                              },
                              child: Text(
                                'Absence Type: ${GetIt.I<AbsenceBloc>().chosenFilter.absenceType.name}',
                              ),
                            ),
                            SizedBox(width: 4.0),
                            if (state is AbsenceUpdateFiltersListState || state is AbsenceloadedState)
                              if (GetIt.I<AbsenceBloc>().chosenFilter.startDate != null && GetIt.I<AbsenceBloc>().chosenFilter.endDate != null)
                                OutlinedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => CustomDialog(),
                                    );
                                  },
                                  child: Text(
                                    '${GetIt.I<AbsenceBloc>().chosenFilter.startDate!.toLocal().toString().split(' ')[0]} - ${GetIt.I<AbsenceBloc>().chosenFilter.endDate!.toLocal().toString().split(' ')[0]}',
                                  ),
                                ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 1),
        ],
      ),
    );
  }
}
