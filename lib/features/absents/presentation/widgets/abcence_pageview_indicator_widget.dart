import 'package:crewmeister_task/features/absents/presentation/blocs/absence_bloc/absence_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class PageViewIndicatorWidget extends StatelessWidget {
  const PageViewIndicatorWidget({
    super.key,
  });

  void onNextPage(int index) => GetIt.I<AbsenceBloc>().add(AbsenceListLoadSingelageEvent(page: index));
  void onPreviousPage(int index) => GetIt.I<AbsenceBloc>().add(AbsenceListLoadSingelageEvent(page: index));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsenceBloc, AbsenceState>(
      buildWhen: (previous, current) => current is AbsenceloadedState,
      builder: (context, state) {
        final int currentPage = GetIt.I<AbsenceBloc>().getCurrentPageIndex();
        final int totalPages = GetIt.I<AbsenceBloc>().getTotalPages();

        // Calculate the range of visible page numbers
        List<int> visiblePages = List.generate(3, (index) {
          int page = currentPage - 1 + index;
          return page >= 1 && page <= totalPages ? page : -1;
        }).where((page) => page != -1).toList();
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: currentPage > 1 ? () => onPreviousPage(currentPage - 1) : null,
              icon: const Icon(Icons.arrow_left),
              tooltip: 'Previous Page',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: visiblePages.map((page) {
                bool isActive = page == currentPage;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    page.toString(),
                    style: isActive
                        ? TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          )
                        : Theme.of(context).textTheme.bodySmall,
                  ),
                );
              }).toList(),
            ),
            IconButton(
              onPressed: currentPage < totalPages ? () => onNextPage(currentPage + 1) : null,
              icon: const Icon(Icons.arrow_right),
              tooltip: 'Next Page',
            ),
          ],
        );
      },
    );
  }
}
