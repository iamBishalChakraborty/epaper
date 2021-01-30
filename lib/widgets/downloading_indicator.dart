import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class DownLoadingIndicator extends StatelessWidget {
  DownLoadingIndicator({this.progress});
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularStepProgressIndicator(
        child: Center(
          child: Text(
            '${progress.toInt()} %',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
          ),
        ),
        totalSteps: 100,
        currentStep: progress.toInt(),
        stepSize: 8,
        selectedColor: Colors.greenAccent,
        unselectedColor: Colors.grey[200],
        padding: 0,
        width: 150,
        height: 150,
        selectedStepSize: 15,
        roundedCap: (_, __) => true,
      ),
    );
  }
}
