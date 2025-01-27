import 'package:crewmeister_task/features/absents/domain/entities/enums/absent_type.dart';
import 'package:crewmeister_task/features/absents/domain/entities/filter.dart';
import 'package:crewmeister_task/features/absents/presentation/blocs/absence_bloc/absence_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  late AbsentType selectedabsentType;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  @override
  void initState() {
    selectedabsentType = GetIt.I<AbsenceBloc>().chosenFilter.absenceType;
    selectedStartDate = GetIt.I<AbsenceBloc>().chosenFilter.startDate;
    selectedEndDate = GetIt.I<AbsenceBloc>().chosenFilter.endDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Filter',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Divider(color: Theme.of(context).colorScheme.onSurface),
              // Dropdown menu
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Type : ',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  DropdownButton<AbsentType>(
                    value: selectedabsentType,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    borderRadius: BorderRadius.circular(10),
                    underline: Container(),
                    items: AbsentType.values.map((value) {
                      return DropdownMenuItem<AbsentType>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedabsentType = value ?? AbsentType.all;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 8.0),
              const Divider(indent: 32, endIndent: 32),
              const SizedBox(height: 8.0),

              // Start Date picker
              Row(
                children: [
                  Text(
                    'form : ',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        // labelText: 'Start Date',
                        hintText: selectedStartDate != null ? '${selectedStartDate!.toLocal()}'.split(' ')[0] : 'Pick a date',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedEndDate != null ? selectedEndDate!.subtract(Duration(days: 1)) : DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: selectedEndDate != null ? selectedEndDate! : DateTime(2101),
                        );
                        if (picked != null) {
                          setState(() {
                            selectedStartDate = picked;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedStartDate = null;
                      });
                    },
                    child: Text('Clear'),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // End Date picker
              Row(
                children: [
                  Text(
                    'to :    ',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        // labelText: 'End Date',
                        hintText: selectedEndDate != null ? '${selectedEndDate!.toLocal()}'.split(' ')[0] : 'Pick a date',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedStartDate != null ? selectedStartDate!.add(Duration(days: 1)) : DateTime.now(),
                          firstDate: selectedStartDate != null ? selectedStartDate! : DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          setState(() {
                            selectedEndDate = picked;
                          });
                        }
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedEndDate = null;
                      });
                    },
                    child: Text('Clear'),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Confirm button
              OutlinedButton(
                onPressed: () {
                  GetIt.I<AbsenceBloc>().add(
                    AbsenceFilterEvent(
                      selectedFilter: FilterAbsence(
                        absenceType: selectedabsentType,
                        startDate: selectedStartDate,
                        endDate: selectedEndDate,
                      ),
                    ),
                  );
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Apply',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
