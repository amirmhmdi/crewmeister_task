import 'package:crewmeister_task/features/absents/presentation/blocs/absence_bloc/absence_bloc.dart';
import 'package:crewmeister_task/features/absents/presentation/widgets/absence_card_widget.dart';
import 'package:crewmeister_task/features/absents/presentation/widgets/absence_dialog_filter.dart';
import 'package:crewmeister_task/features/absents/presentation/widgets/absence_failur_widget.dart';
import 'package:crewmeister_task/features/absents/presentation/widgets/absence_loading_widget.dart';
import 'package:crewmeister_task/features/absents/presentation/widgets/bottom_appbar_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AbsenceListScreen extends StatefulWidget {
  const AbsenceListScreen({super.key});

  @override
  State<AbsenceListScreen> createState() => _AbsenceListScreenState();
}

class _AbsenceListScreenState extends State<AbsenceListScreen> {
  late RefreshController _refreshController;
  @override
  void initState() {
    GetIt.I<AbsenceBloc>().add(AbsenceListFetchEvent());
    _refreshController = RefreshController(initialRefresh: false);
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
            _refreshController.loadComplete();
            _refreshController.refreshCompleted();
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: GetIt.I<AbsenceBloc>().enableLoadmore(state.absenceList.length),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: GetIt.I<AbsenceBloc>().enableLoadmore(state.absenceList.length) == true ? _onLoading : null,
              child: ListView.builder(
                itemCount: state.absenceList.length,
                itemBuilder: (context, index) {
                  return AbsenceCardWidget(
                    absence: state.absenceList[index],
                  );
                },
              ),
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

  _onRefresh() {
    GetIt.I<AbsenceBloc>().add(AbsenceListFetchEvent());
  }

  _onLoading() {
    GetIt.I<AbsenceBloc>().add(AbsenceListLoadmoreEvent());
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
