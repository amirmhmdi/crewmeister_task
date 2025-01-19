import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AbsenceLoadingWidget extends StatelessWidget {
  const AbsenceLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage('assets/crew_meister.png')),
          Text(
            'Waiting, Loading data form server',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          CircularProgressIndicator(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
