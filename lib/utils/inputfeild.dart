import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:reminder_flutter/services/theme.dart';
class MyInputFeild extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  MyInputFeild({required this.title,required this.hint,this.controller, this.widget});



  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: smaillHeadingStyle,),
        const   SizedBox(height: 10,),
          Container(
            padding:const  EdgeInsets.only(left: 14),
            height: 53,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(child: TextFormField(
                  controller: controller,
                  readOnly: widget==null?false:true,
                  autofocus: false,
                  style: enteTextStyle,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: enteTextStyle,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                        color: context.theme.backgroundColor,
                        width: 0
                      )
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                            width: 0
                        )
                    ),
                  ),
                  cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey[700],
                )),
                widget==null?Container():Container(
                  child: widget,
                )
              ],
            ),
          )


        ],

      ),
    );
  }
}
