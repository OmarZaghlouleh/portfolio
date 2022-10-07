import 'package:flutter/cupertino.dart';

class AppSize {
  static const double s1 = 1;
  static const double s5 = 5;
  static const double s10 = 10;
  static const double s15 = 15;
  static const double s20 = 20;
  static const double s25 = 25;
  static const double s30 = 30;
  static const double s40 = 40;
  static const double s50 = 50;
  static const double s60 = 60;
  static const double s80 = 80;
  static const double s100 = 100;
  static const double s1000 = 1000;
}

class AppOffset {
  static const double of0 = 0;
  static const double of1 = 1;
  static const double of5 = 5;
  static const double of10 = 10;
}

class DeviceSize {
  double maxWidth = 750;
  BuildContext context;
  DeviceSize(this.context);

  double get getWidth => MediaQuery.of(context).size.width;
  double get getQurterWidth => MediaQuery.of(context).size.width * 0.25;
  double get getHeight => MediaQuery.of(context).size.height;
}

class Vector2 {
  double x;
  double y;
  Vector2(this.x, this.y);
}

class CirclePositionDif {
  static const int x = 20;
  static const int y = 20;
}

class AppDurations {
  static const int d0 = 0;
  //Milliseconds
  static const int dm100 = 100;
  static const int dm150 = 150;
  static const int dm250 = 250;
  static const int dm300 = 300;
  static const int dm350 = 350;
  //seconds
  static const int ds1 = 1;
  static const int ds2 = 2;
  static const int ds3 = 3;
  static const int ds4 = 4;
}

class TweenValues {
  static const double t0 = 0;
  static const double t1 = 1;
  static const double t1_5 = 1.5;
  static const double t2 = 2;
}

class OpacityValues {
  static const double op0 = 0;
  static const double op0_1 = 0.1;
  static const double op0_2 = 0.2;
  static const double op0_3 = 0.3;
  static const double op0_4 = 0.4;
  static const double op0_5 = 0.5;
  static const double op0_6 = 0.6;
  static const double op0_7 = 0.7;
  static const double op0_8 = 0.8;
  static const double op0_9 = 0.9;
  static const double op1 = 1;
}

class AppPadding {
  static const double p4 = 4;
  static const double p6 = 6;
  static const double p8 = 8.0;
  static const double p25 = 25.0;
  static const double p50 = 50.0;
}

class AppHeights {
  static const double zero = 0;

  static const double h10 = 10;
  static const double h15 = 15;
  static const double h20 = 20;
  static const double h100 = 100;
  static const double h200 = 200;
  static const double h250 = 250;
  static const double h300 = 300;
  static const double h400 = 400;
  static const double h500 = 500;
  static const double h550 = 550;
  static const double h600 = 600;
  static const double h700 = 700;
  static const double h800 = 800;
  static const double h900 = 900;
  static const double h1000 = 1000;
  static const double h1100 = 1100;
}

class AppWidth {
  static const double w5 = 5;
  static const double w10 = 10;
  static const double w15 = 15;
  static const double w20 = 20;
  static const double w30 = 30;
  static const double w50 = 50;
  static const double w55 = 55;
  static const double w65 = 65;
  static const double w75 = 75;
  static const double w100 = 100;
  static const double w200 = 200;
  static const double w300 = 300;
  static const double w350 = 350;
  static const double w400 = 400;
  static const double w500 = 500;
}

class AppFractions {
  static const double f0_1 = 0.1;
  static const double f0_2 = 0.2;
  static const double f0_3 = 0.3;
  static const double f0_4 = 0.4;
  static const double f0_5 = 0.5;
  static const double f0_6 = 0.6;
  static const double f0_7 = 0.7;
  static const double f0_8 = 0.8;
  static const double f0_9 = 0.9;
  static const double f1 = 1;
}

class AppFlex {
  static const int f1 = 1;
  static const int f2 = 2;
  static const int f3 = 3;
  static const int f4 = 4;
  static const int f5 = 5;
  static const int f6 = 6;
  static const int f7 = 7;
  static const int f8 = 8;
  static const int f9 = 9;
  static const int f10 = 10;
}
