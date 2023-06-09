import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:public_safety_app/utils/dimension.dart';

class DatePicker extends StatefulWidget {

  final TextEditingController controller;


  DatePicker({
    required this.controller,
    super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  String? _date;
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput= widget.controller; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: Dimensions.width180,
        // decoration: BoxDecoration(color: Colors.blueAccent),
        child: Column(
          children: [

            // Label Text
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: Text(
                    'Date',
                    style: TextStyle(
                        color: Color.fromARGB(255, 14, 114, 22),
                        fontSize: Dimensions.font20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            // Text Feild
            Container(
              margin: EdgeInsets.only(left: Dimensions.width15, bottom: Dimensions.height15, top: Dimensions.height5),

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
                padding:EdgeInsets.only(left: Dimensions.width5,),
                child: TextFormField(

                  controller: dateInput,

                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Color.fromARGB(255, 14, 114, 22), size: Dimensions.icon30,
                    ),
                    hintText: 'dd-mm-yyyy',
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 61, 180, 71),
                        fontSize: Dimensions.font15,
                        fontWeight: FontWeight.w500),
                    border: InputBorder.none,
                  ),

                  readOnly: true,

                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(

                              textTheme: TextTheme(
                                  titleLarge:
                                      TextStyle(fontWeight: FontWeight.bold)
                                    ),
                              colorScheme: ColorScheme.light(
                                primary: Color.fromARGB(
                                    255, 14, 114, 22), // <-- SEE HERE
                                onPrimary: Colors.white, // <-- SEE HERE
                                onSurface: Colors.black, // <-- SEE HERE
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor:
                                      Colors.red, // button text color
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      
                      // after formating show on the textfeild selected value
                      setState(() {
                        dateInput.text = formattedDate;
                      });
                      } 
                      else {
                      setState(() {
                        dateInput.text = 'dd-mm-yyyy';
                      }
                      );

                    }
                  },

                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter a date';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _date = value;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}