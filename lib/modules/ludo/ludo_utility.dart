import 'package:flutter/material.dart';

class Utility {
  static Color getColor(int row, int column) {
    //Green
    if ((row == 0 || row == 5) && column <= 5) {
      return const Color(0XFF00AF50);
    }
    if ((column == 0 || column == 5) && row <= 5) {
      return const Color(0XFF00AF50);
    }
    //Yellow
    if ((row == 0 || row == 5) && (column >= 9 && column <= 14)) {
      return const Color(0XFFFFFF00);
    }
    if ((column == 9 || column == 14) && row <= 5) {
      return const Color(0XFFFFFF00);
    }
    //Red
    if ((row == 9 || row == 14) && column <= 5) {
      return const Color(0XFFFE0000);
    }
    if ((column == 0 || column == 5) && (row >= 9 && row <= 14)) {
      return const Color(0XFFFE0000);
    }
    //Blue
    if ((column == 9 || column == 14) && (row >= 9 && row <= 14)) {
      return const Color(0XFF0070BD);
    }
    if ((row == 9 || row == 14) && (column >= 9 && column <= 14)) {
      return const Color(0XFF0070BD);
    }
    return Colors.transparent;
  }
}