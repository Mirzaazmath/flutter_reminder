import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reminder_flutter/controller/task_controller.dart';
import 'package:reminder_flutter/services/notification_services.dart';
import 'package:reminder_flutter/services/themeService.dart';

import '../model/taskmodel.dart';
import '../services/theme.dart';
import '../utils/mybutton.dart';
import '../utils/tasktile.dart';
import 'addtaskscreen.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Here we are creating a variable of tpye Datetime to store date
  DateTime _selectedDate=DateTime.now();

  // here we creating the instance of taskcontroller class
  final _taskcontroller=Get.put(TaskController());
  late bool is24HoursFormat;

  // here we creating the instance for  NotifyHelper
  var notifyHelper;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // here we are calling the NotifyHelper class
    notifyHelper=NotifyHelper();
    // here we are calling the NotifyHelper class intializer
    notifyHelper.initializeNotification();
    // here we are calling the NotifyHelper class request for permission method
    notifyHelper.requestIOSPermissions();
    // here we are call a function get all task from database
    _taskcontroller.getTask();




  }
  @override
  Widget build(BuildContext context) {



     is24HoursFormat = MediaQuery.of(context).alwaysUse24HourFormat;
     print(is24HoursFormat);

   


    //
   // Scaffold Widget is used under MaterialApp, it gives you many basic functionalities, like AppBar, BottomNavigationBar, Drawer, FloatingActionButton, etc.
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      // here we are reusing the appwidget it helps to reduce both time and code
      appBar: _appbar(),
      body: Column(
        children: [
        const   SizedBox(height: 10,),
          // Note : for Better understanding we have divided the code into small blocks

          // This block contains add task button
          _addtaskbar(),
          // This block contains the Timeline Calender section of home screen
          _adddatebar(),
          // This block contains the list of task
          _showtasks(),



        ],
      ),

    );
  }
  _showtasks(){
    return Expanded(child:Obx((){
      return ListView.builder(
        itemCount:_taskcontroller.taskList.length,
          itemBuilder: (context,index){
          Task task = _taskcontroller.taskList[index];
           if(task.repeat=="Daily"){
            // print(task.startTime);

             String formatedtime= task.startTime.contains("AM")||task.startTime.contains("PM")?task.startTime:"${(int.parse(task.startTime.toString().split(":")[0])<=12?task.startTime.toString().split(":")[0]:((int.parse(task.startTime.toString().split(":")[0])-12).toString() ))}:${task.startTime.toString().split(":")[1]} ${(int.parse(task.startTime.toString().split(":")[0])<=12?"AM":"PM")}";
            // print(formatedtime);




                                                                                                                                                                                           // DateFormat.jm().format(DateTime.parse(timeStamp24HR))

             DateTime date =    is24HoursFormat ? DateFormat.Hm().parse(task.startTime):DateFormat.jm().parse(formatedtime);
             var mytime= DateFormat("HH:mm").format(date);
             notifyHelper.scheduledNotification(
               int.parse(mytime.toString().split(":")[0]),
                 int.parse(mytime.toString().split(":")[1]),
               task
             );
                       return AnimationConfiguration.staggeredList(
            position: index, child: FadeInAnimation(
          child:Row(
            children: [
              GestureDetector(
                onTap: (){
                  _showBottomSheet(context,task);
                },
                child: TaskTile(task),

              )
            ],
          ) ,
        ));

      } if(task.date==DateFormat.yMd().format(_selectedDate)){
             return AnimationConfiguration.staggeredList(
                 position: index, child: FadeInAnimation(
               child:Row(
                 children: [
                   GestureDetector(
                     onTap: (){
                       _showBottomSheet(context,task);
                     },
                     child: TaskTile(task),

                   )
                 ],
               ) ,
             ));
          }else{
             return Container();
          }

     }
      );
    }) );
  }
  _showBottomSheet(context,Task task){
    Get.bottomSheet(Container(
      color:Get.isDarkMode?darkgreycolor:Colors.white ,
      padding:const  EdgeInsets.only(top: 4),
    //  height: task.isCompleted==1?MediaQuery.of(context).size.height*0.24:MediaQuery.of(context).size.height*0.32,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300]
            ),

          ),
        const   SizedBox(height: 20,),


          task.isCompleted==1?Container():_custombutton(label: "Task Completed",onTap: (){
            _taskcontroller.markTaskCompleted(task.id!);
            Get.back();
          },
            clr: bluishClr

          ),
          const SizedBox(height: 20,),
          _custombutton(label: "Delete Task",onTap: (){
            _taskcontroller.delete(task);


            Get.back();
          },
              clr: Colors.red

          ),
          const SizedBox(height: 30,),
          _custombutton(label: "Cancel",onTap: (){
            Get.back();
          },
              clr: Colors.red,
            isClose: true


          ),
          const SizedBox(height: 10,),

        ],
      ),

    ));

  }

  _custombutton({
    required String label,
    required Function() onTap,
    required Color clr,
    bool isClose=false,
  }){
    return GestureDetector(
      onTap: onTap,
      child: Container(

        height:55,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(width: 2,color:isClose==true? Get.isDarkMode?Colors.grey[600]!:Colors.grey[300]!: clr, ),
          color: isClose==true?Colors.transparent: clr,
          borderRadius: BorderRadius.circular(10)

        ),
        alignment: Alignment.center,
        margin:const  EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        child: Text(label,style:isClose?smaillHeadingStyle: smaillHeadingStyle.copyWith(color: Colors.white),),
      ),

    );

  }



  _adddatebar(){
    return  Container(
      margin:const  EdgeInsets.all(10),
      child: DatePicker(
        DateTime.now(),
        height: 80,
        width: 60,
        initialSelectedDate: DateTime.now(),
        selectionColor: bluishClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey
          ),
        ),
        dayTextStyle:  GoogleFonts.lato(
          textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey
          ),
        ),
        onDateChange: (date){
          setState(() {
            _selectedDate=date;
          });

        },

      ),
    );
  }
  _addtaskbar(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(DateFormat.yMMMMd().format(DateTime.now()),style: subHeadingStyle,),
              Text("Today",style: smaillHeadingStyle,)
            ],
          ),

        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: MyBotton(title: "+ Add Task",ontap: ()async{
            // Navigate though get
           await  Get.to(AddTaskScreen(is24HoursFormat));
           _taskcontroller.getTask();
          },),
        ),

      ],
    );
  }

  _appbar(){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      // Gesture Dectector is used to add click fuctions
      leading: GestureDetector(
        onTap: (){
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
            title:"Theme Changed",
              body:Get.isDarkMode?"Activated Light Theme":"Activated Dark Theme",
          );
          // notifyHelper.scheduledNotification();



        },

        child:  Icon(Get.isDarkMode? Icons.wb_sunny_outlined:Icons.nightlight_rounded,size: 28,color: Get.isDarkMode?Colors.white:Colors.black,),
      ),
      actions:  [
        CircleAvatar(radius: 20,
        backgroundColor:  Get.isDarkMode?Colors.black:Colors.white,
        child: Icon(Icons.account_circle,size: 30,),),
        SizedBox(width: 10,)
      ],
    );

  }
}
