import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:reminder_flutter/services/theme.dart';
class NotifyScreen extends StatelessWidget {
  final  label;
  const NotifyScreen({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bluishClr,
        leading: IconButton(
          onPressed: (){
            Get.back();

          },
          icon: Icon(Icons.arrow_back_ios,color:Colors.white,),
        ),title:Text(this.label.toString().split("|")[0],style: TextStyle(color: Colors.white),),

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("HELLO, USER",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),

          Text("You have a new reminder",style: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.bold),),

          SizedBox(height: 30,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.all(20),
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              color: bluishClr,
              borderRadius: BorderRadius.circular(30)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(children: [
                  Icon(Icons.title,color: Colors.white,size: 40,),
                  SizedBox(width: 10,),
                  Text("Title",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)),

                ],),
                SizedBox(height: 20,),
                Text(this.label.toString().split("|")[0],style: TextStyle(color: Colors.white,fontSize: 20),),
                SizedBox(height: 20,),
                Row(children: [
                  Icon(Icons.description,color: Colors.white,size: 40,),
                  SizedBox(width: 10,),
                  Text("Description",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)),

                ],),
                SizedBox(height: 20,),
                Text(this.label.toString().split("|")[1] ,style: TextStyle(color: Colors.white,fontSize: 15),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,),
                SizedBox(height: 20,),
                Row(children: [
                  Icon(Icons.schedule,color: Colors.white,size: 40,),
                  SizedBox(width: 10,),
                  Text("Time",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)),


                ],),
      SizedBox(height: 20,),
      Text(this.label.toString().split("|")[2] ,style: TextStyle(color: Colors.white,fontSize: 15),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
