import 'package:flutter/material.dart';

import '../services/theme.dart';
class MyBotton extends StatelessWidget {
  VoidCallback ontap;
  String title;
  MyBotton({required this.ontap,required this.title});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: bluishClr,

        ),
        alignment: Alignment.center,
        child: Text(title,style:const  TextStyle(color: Colors.white),),
      ),
    );
  }
}
