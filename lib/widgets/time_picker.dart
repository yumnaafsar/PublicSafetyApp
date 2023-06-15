import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:public_safety_app/utils/dimension.dart';

class TimePicker extends StatefulWidget {

  final TextEditingController controller;
  TimePicker({
    required this.controller,
    super.key});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  String? _time;
  TextEditingController timeInput = TextEditingController();

  @override
  void initState() {
    timeInput= widget.controller; // set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
            width: Dimensions.width170,
            // decoration: BoxDecoration(color: Colors.blueAccent),
            child: Column(children: [
              // Label Text
              Row(
                children: [
                  Padding(
                    padding:EdgeInsets.only(left: Dimensions.width20,),
                    child: Text(
                      'Time',
                      style: TextStyle(
                          color: Color.fromARGB(255, 14, 114, 22),
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              // Text Field
              Container(
                  margin: EdgeInsets.only(left: Dimensions.width15, bottom: Dimensions.height15, top: Dimensions.height5, right: Dimensions.width10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius35),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 14, 114, 22),
                          blurRadius: 5.0,
                          offset: Offset(0, 5)),
                      BoxShadow(
                          color: Color.fromARGB(255, 14, 114, 22),
                          blurRadius: 5.0,
                          offset: Offset(-5, 5))
                    ],
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(left: Dimensions.width5),
                      child: TextFormField(
                        controller: timeInput,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.access_time,
                            color: Color.fromARGB(255, 14, 114, 22),size: Dimensions.icon30,
                          ),
                          hintText: 'hh:mm',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 61, 180, 71),
                              fontSize: Dimensions.font15,
                              fontWeight: FontWeight.w500),
                          border: InputBorder.none,
                        ),
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (BuildContext context, Widget? child) {
                              return MediaQuery(
                                data: MediaQuery.of(context).copyWith(
                                  alwaysUse24HourFormat:
                                      false, // set to true for 24-hour format
                                ),
                                child: child!,
                              );
                            },
                          );

                          if (pickedTime != null) {
                            String formattedTime = DateFormat.Hm().format(
                                DateTime.now()
                                    .subtract(Duration(hours: 24))
                                    .add(Duration(
                                        hours: pickedTime.hour,
                                        minutes: pickedTime.minute)));

                            // after formatting show the selected value in the text field
                            setState(() {
                              timeInput.text = formattedTime;
                            });
                          } else {
                            setState(() {
                              timeInput.text = 'hh:mm';
                            });
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter a time';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _time = value;
                        },
                      )))
            ])));
  }
}
