import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:reminder_flutter/db/dbhelper.dart';
import 'package:reminder_flutter/screen/homeScreen.dart';
import 'package:reminder_flutter/services/theme.dart';
import 'package:reminder_flutter/services/themeService.dart';
// The Flutter Start the Execution of the program from here the main function
void main()async{
  // until the get storage init this hold the progrom and prevent the crash
  // and it ensure that get Storage is init first
  // to prevent error
  WidgetsFlutterBinding.ensureInitialized();

  // Here we are initializing the local database by using sflite package

  await DbHelper.initDb();
  // Here we are initializing the Get Storage to use it in entire app
  // note :
  // because it is a future method we get an error to overcone the error we add this upper line code

  await GetStorage.init();

  //this indicates the flutter engine to run this class first
  runApp(MyApp());
}
// This is our basic Class all the application Aka root class
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We Use MaterialApp Because
    //Material is a design system created by Google to help teams build high-quality digital experiences for Android, iOS, Flutter, and the web.
    // basically it is a design Structure

    return GetMaterialApp(
      // this is use for removing the debug banner just set it to false
      debugShowCheckedModeBanner: false,
      // In The Theme we declare our entire application colors or text theme etc
      // Here we are calling the Light Theme from theme class
      theme: Themes.light,

      // here you can see we are able to change theme mode from light to dark

      // we are calling the thememode function of themeservice class that we create
      themeMode: ThemeService().theme,
      // Here we are calling the dark Theme from theme class
      darkTheme: Themes.dark,
      // The home describe where is our first landing screen
      home: HomePage(),
    );
  }
}
