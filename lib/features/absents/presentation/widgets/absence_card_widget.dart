import 'package:crewmeister_task/features/absents/domain/entities/absence.dart';
import 'package:crewmeister_task/features/absents/domain/entities/enums/absent_status.dart';
import 'package:crewmeister_task/features/absents/presentation/blocs/absence_bloc/absence_bloc.dart';
import 'package:crewmeister_task/features/absents/presentation/widgets/absence_get_email_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AbsenceCardWidget extends StatefulWidget {
  final Absence absence;

  const AbsenceCardWidget({
    super.key,
    required this.absence,
  });

  @override
  State<AbsenceCardWidget> createState() => _AbsenceCardWidgetState();
}

class _AbsenceCardWidgetState extends State<AbsenceCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8.0),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            widget.absence.memberInfo?.image ?? '',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.absence.memberInfo?.name ?? 'User not Exist',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Type: ${widget.absence.type.name}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 8),
                              if (widget.absence.memberNote != '')
                                Text(
                                  'Note: ${widget.absence.memberNote}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(thickness: 1),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Period: ${widget.absence.startDate.toLocal().toString().split(' ')[0]} , ${widget.absence.endDate.toLocal().toString().split(' ')[0]}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        if (widget.absence.admitterNote.isNotEmpty)
                          Text(
                            'Admitter Note: ${widget.absence.admitterNote}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () async {
                                String? email = await showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return GetEmailDialogWidget();
                                  },
                                );

                                if (email != null) {
                                  GetIt.I<AbsenceBloc>().add(
                                    AbsenceListSentEmailWithICSEvent(
                                      absence: widget.absence,
                                      email: email,
                                    ),
                                  );
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Share .ICS file by Email'),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Icon(Icons.attach_email_outlined),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            RotatedBox(
              quarterTurns: 1,
              child: Container(
                padding: EdgeInsets.all(8.0),
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  color: chooseStatusColor(widget.absence.absentStatus),
                ),
                child: Text(
                  widget.absence.absentStatus.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color chooseStatusColor(AbsentStatus absentStatus) {
    switch (absentStatus) {
      case AbsentStatus.confirmed:
        return Colors.green;
      case AbsentStatus.rejected:
        return Colors.red;
      case AbsentStatus.requested:
        return Colors.orange;
    }
  }
}
