import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
const Color bluishClr=Color(0xff4e5ae8);
const Color yelloish=Color(0xFFFFB746);
const Color pinkish=Color(0xFFff4667);
const Color darkgreycolor=Color(0xff121212);
const Color white=Colors.white;
const Color darkHeaderclr=Color(0xff424242);


// Here we are create separate file or class for manage the theme
class Themes{
  //Light Theme
  static final light= ThemeData(
    backgroundColor:Colors.white,
      primaryColor: bluishClr,
      brightness: Brightness.light
  );
  //Dark Theme
  static final dark=ThemeData(
    backgroundColor: darkgreycolor,
      primaryColor: darkgreycolor,
      brightness: Brightness.dark
  );
}
TextStyle get subHeadingStyle{
  return  GoogleFonts.lato(
    textStyle:  TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode?Colors.grey[400]:Colors.grey,
    )
  );
}
TextStyle get smaillHeadingStyle{
  return  GoogleFonts.lato(
      textStyle:  TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        color: Get.isDarkMode?Colors.white:Colors.black,
      )
  );
}
TextStyle get enteTextStyle{
  return  GoogleFonts.lato(
      textStyle:  TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode?Colors.grey[100]:Colors.grey[700],
      )
  );
}