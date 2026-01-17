import 'package:flutter/material.dart';

int calculateGridCount(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  if(width<600){
    return 2;
  } else if (width >= 600 && width < 900) {
    return 3;
  } else if (width >= 900 && width < 1200) {
    return 4;
  } else {
    return 5;
  }
}
