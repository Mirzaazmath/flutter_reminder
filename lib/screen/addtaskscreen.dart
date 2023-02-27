import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:reminder_flutter/controller/task_controller.dart';
import 'package:reminder_flutter/model/taskmodel.dart';
import 'package:reminder_flutter/services/theme.dart';
import 'package:reminder_flutter/utils/mybutton.dart';

import '../utils/inputfeild.dart';

class AddTaskScreen extends StatefulWidget {
  bool is24HoursFormat;
  AddTaskScreen(this.is24HoursFormat);


  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TaskController _taskController=Get.put(TaskController());
  TextEditingController _titlecontroller=TextEditingController();
  TextEditingController _notecontroller=TextEditingController();
  DateTime _selecteddate=DateTime.now();
  String _endTime="9:30 PM";
  String _startTime=DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind=5;
  List<int>remindlist=[
    5,10,15,20
  ];
  String _selectedRepeat="None";
  List<String>repeatlist=[
    "None","Daily","Weekly","Monthly","Yearly"
  ];
  int _selctedcolor=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startTime=widget.is24HoursFormat? DateFormat.Hm().format(DateTime.now()).toString():DateFormat("hh:mm a").format(DateTime.now()).toString();
    _endTime=widget.is24HoursFormat? DateFormat.Hm().format(DateTime.now()).toString():DateFormat("hh:mm a").format(DateTime.now()).toString();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appbar(context),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Add Task",style: subHeadingStyle,),
              MyInputFeild(title: "Title",hint: "Enter title here",controller: _titlecontroller,),
              MyInputFeild(title: "Note",hint: "Enter your note",controller: _notecontroller,),
              MyInputFeild(title: "Date",hint: DateFormat.yMd().format(_selecteddate),widget: IconButton(
                icon:const  Icon(Icons.calendar_today_outlined,color: Colors.grey,),
                onPressed: (){
                  _getdatefromuser();


                },
              ),),
              Row(
                children: [
                  Expanded(child:  MyInputFeild(title: "Start Time",hint: _startTime,widget: IconButton(
                    icon:const   Icon(Icons.access_time_rounded,color: Colors.grey,),
                    onPressed: (){
                      _getstarttimefromuser();


                    },
                  ),),),
                 const  SizedBox(width: 20,),
                  Expanded(child:  MyInputFeild(title: "End Time",hint: _endTime,widget: IconButton(
                    icon:const  Icon(Icons.access_time_rounded,color: Colors.grey,),
                    onPressed: (){
                      _getendtimefromuser();


                    },
                  ),),),


                ],
              ),
              MyInputFeild(title: "Remind",hint: "$_selectedRemind minutes early",widget:DropdownButton(
                icon: const Icon(Icons.keyboard_arrow_down,color: Colors.grey,size: 32,),
                  elevation: 4,
                underline: Container(height: 0,),
                style: enteTextStyle,
                items: remindlist.map<DropdownMenuItem<String>>((int value){
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                      child: Text(value.toString()));

                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedRemind=int.parse(value!);
                  });
                },
              ) ),
              MyInputFeild(title: "Repeat",hint: _selectedRepeat.toString() ,widget:DropdownButton(
                icon: const Icon(Icons.keyboard_arrow_down,color: Colors.grey,size: 32,),
                elevation: 4,
                underline: Container(height: 0,),
                style: enteTextStyle,
                items: repeatlist.map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()));

                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedRepeat=value!;
                  });
                },
              ) ),
              const SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Color",style: smaillHeadingStyle,),
                    const SizedBox(height: 8,),
                    Wrap(
                      children: List<Widget>.generate(3, (index) { return
                         GestureDetector(
                           onTap: (){
                           setState(() {
                             _selctedcolor=index;
                           });

                           },
                           child: Padding(
                        padding: const  EdgeInsets.only(right: 8),
                        child: CircleAvatar(
                            radius: 14,
                            backgroundColor: index==0?bluishClr:index==1?pinkish:yelloish,
                          child:_selctedcolor==index? const Icon(Icons.done,color: Colors.white,size: 16,):Container()
                        ),
                      ),
                         );})
                        
                      
                    )
                  ],
                ),
                  MyBotton(ontap: (){
                    _validatedate();
                  }, title: "Create Task")
                ],
              )



            ],
          ),
        ),
      ),

    );
  }
  _validatedate(){
    if(_titlecontroller.text.isNotEmpty&&_notecontroller.text.isNotEmpty){
      _adddatetodatabase();
      Get.back();
    }else if(_titlecontroller.text.isEmpty||_notecontroller.text.isEmpty){
      Get.snackbar("Required", "All feilds are required",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: pinkish,
      icon: const Icon(Icons.warning_amber_rounded,color: Colors.red,),);
    }

  }
  _adddatetodatabase() async {
 var value = await   _taskController.addTask(task:
    Task(
      note: _notecontroller.text,
      title: _titlecontroller.text,
      date: DateFormat.yMd().format(_selecteddate),
      startTime: _startTime,
      endTime: _endTime,
      remind: _selectedRemind,
      repeat: _selectedRepeat.toString(),
      color: _selctedcolor,
      isCompleted: 0,

    ));


  }
  _getstarttimefromuser()async{
    var picktime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(hour: 9, minute: 00));
    String _formatedTime = picktime!.format(context);
    if(picktime !=null){
      setState(() {
        _startTime=_formatedTime;
        print("this is actual time $picktime");
        print("this is formated time $_formatedTime");
        print("this value is going to save in database$_startTime");

      });
    }else{
      debugPrint("Something went wrong");
    }


  }
  _getendtimefromuser()async{
    var picktime = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(hour: 9, minute: 00));
    String _formatedTime = picktime!.format(context);
    if(picktime !=null){
      setState(() {
        _endTime=_formatedTime;

      });
    }else{
      debugPrint("Something went wrong");
    }


  }

  _getdatefromuser()async{
    DateTime? _pickeddate= await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate:  DateTime(2015),
        lastDate: DateTime(2045),
    );
    if(_pickeddate !=null){
     setState(() {
       _selecteddate=_pickeddate;
     });
    }else{
      debugPrint("Something went wrong");
    }
  }

  _appbar(context){
    return AppBar(
      elevation: 0,
       backgroundColor: Get.isDarkMode?Colors.black:Colors.white,
      leading: GestureDetector(
        onTap: (){
          Get.back();
        },

          child: Icon(Icons.arrow_back_ios,color:  Get.isDarkMode?Colors.white:Colors.black,)),



      actions:const  [
        CircleAvatar(radius: 20,),
        SizedBox(width: 10,)
      ],
    );

  }
}
