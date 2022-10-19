import 'package:flutter/material.dart';
import 'package:flutter_firebase/utils/colors.dart';

Widget noData(String placeholder) {
  return Center(
      child: Column(
    children: [
      SizedBox(
          height: 200,
          width: 200,
          child: Image.asset("assets/images/healthcare8.png")),
      const SizedBox(height: 16),
      Text(placeholder, style: TextStyle(color: ColorsScheme.primaryColor)),
    ],
  ));
}
