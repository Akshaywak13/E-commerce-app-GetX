
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

loadingIndicator(Color color){
  return Center(
    child: SizedBox(
      height: 20,width: 60,
      child: LoadingIndicator(
        indicatorType: Indicator.ballPulse,
        colors:[color],
        strokeWidth: 2,
        backgroundColor:Colors.transparent,
       
      ),
    ),
  );
}