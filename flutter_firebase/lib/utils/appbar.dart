import 'package:flutter/material.dart';
import 'package:flutter_firebase/utils/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

PreferredSize standardAppBar = PreferredSize(
  preferredSize: Size.fromHeight(150.0),
  child: Container(
    height: 155, 
    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Icon(Icons.arrow_back_ios_new_rounded, size: 25,color: ColorsScheme.primaryColor),
      Icon(Icons.notifications, size: 30,color:ColorsScheme.primaryColor),
    ]),
  ),
);
