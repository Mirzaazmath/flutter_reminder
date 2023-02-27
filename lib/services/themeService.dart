import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService{
  // Here we are initailizing the getstorage  to store some value
  final _box= GetStorage();
  final _key="isDarkMode";
  // GetStorage uses key value to store the data

  // Here we are checking the box contain data or not
  // by its key which is "isDarkMode"
  // it first check the box if the box is empty then it return false
  // because we are using the ?? which means if one condition true it return its value else the next valye
  // after ??
  bool _loadThemeFromBox()=>_box.read(_key)??false;



  // here we are checking and assigning the mode
  // why we use get ?
  // because we cam asscess it from any where with loading the extra package
  ThemeMode get theme=>_loadThemeFromBox()?ThemeMode.dark:ThemeMode.light;

// this function is used to change the theme mode
  void switchTheme(){
    // here we are getting the bool from _loadThemeFromBox() as it empty return false

    Get.changeThemeMode(_loadThemeFromBox()?ThemeMode.light:ThemeMode.dark);

    // after changing the thememode we need to save the new value to the box it rechange to
    // if we dont do the save the every the we call switchTheme we get false only
    // to prevent that we have to save the value every time
    _saveThemeToBox(!_loadThemeFromBox());
  }
  // this  function save the value in  the box
  _saveThemeToBox(bool isDarkMode)=>_box.write(_key, isDarkMode);

}