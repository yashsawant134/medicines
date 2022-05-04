import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medicines/bottom_nav/bottom_nav_bar.dart';
import 'package:medicines/database/DatabaseHelper.dart';
import 'package:medicines/models/search_medicine.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:medicines/modules/MyMedicineModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';

class AddScreens extends StatefulWidget {
  AddScreens({Key? key}) : super(key: key);

  @override
  State<AddScreens> createState() => _AddScreensState();
}

var pList =[];
int dose_qty = 1;
var selectedPName = "Avil 25";
var selectedItem = [];
String selectedtime = "";

  final dbHelper = DatabaseHelper.instance;
class _AddScreensState extends State<AddScreens> {
  void changeInTime(String time) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Add Your Pill's",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Medicine Name",
                    style: TextStyle(color: Colors.grey[600], fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // TextField(
                  //   obscureText: true,
                  // decoration: InputDecoration(
                  //   border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10)),
                  //     hintText: 'Name',
                  //   ),
                  // ),
                  searchProductDropDown(),

                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        "Dose",
                        style: TextStyle(color: Colors.grey[600], fontSize: 20),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            dose_qty--;
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13)),
                              border: Border.all(color: Color(0xFF818595))),
                          child: Center(
                            child: Icon(
                              Icons.remove,
                              color: Color(0xFF818595),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        dose_qty.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            dose_qty++;
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            border: Border.all(color: Color(0xFF52B1FB)),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Color(0xFF52B1FB),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Time",
                    style: TextStyle(color: Colors.grey[600], fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 1.32,
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              Icon(Icons.access_alarm_rounded),
                              SizedBox(
                                width: 12,
                              ),
                              Text(selectedtime)
                            ],
                          )),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          ShowTime();
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Color(0xFFF9A0BA)),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Color(0xFFF9A0BA),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: InkWell(
                onTap:(){
                  _insert(selectedPName, dose_qty,);
                              Navigator.pop(context);

                },
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 9,
                        color: Color(0Xff69bcfc).withOpacity(0.5),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF82C6FB), Color(0XFF69BCFC)],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add Pills",
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildCustomTimer(BuildContext context) {
    return TimePickerSpinner(
      is24HourMode: false,
      normalTextStyle: TextStyle(fontSize: 24, color: Colors.black),
      highlightedTextStyle:
          TextStyle(fontSize: 24, color: Color.fromARGB(255, 79, 213, 250)),
      spacing: 20,
      itemHeight: 50,
      isForce2Digits: false,
      secondsInterval: 1,
      onTimeChange: (time) {
        setState(() {
          selectedtime = time.toString().substring(11, 16);
        });
      },
    );
  }

  void ShowTime() {
    showAdaptiveActionSheet(
      context: context,
      title: const Text(
        'Select time',
        style: TextStyle(color: Colors.black),
      ),
      androidBorderRadius: 30,
      bottomSheetColor: Colors.white,
      actions: [
        BottomSheetAction(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[buildCustomTimer(context)],
            ),
            onPressed: () {}),
      ],
      cancelAction: CancelAction(
          title: const Text(
              'Cancel')), // onPressed parameter is optional by default will dismiss the ActionSheet
    );
  }
}

 void _insert(String name, int dose) async {
   String imgurl="";

   for(int i=0;i<pList.length;i++){
     if(pList[i]['Name']==selectedPName){
       imgurl=pList[i]['Img'];
     }
   }
    // row to insert
    FirebaseFirestore.instance.collection("users").doc(phone).collection("mymedicine").doc().set({'med_name':name,'dose':dose,'medImgUrl':imgurl,'minutes':1700,'time':selectedtime});
  //   Map<String, dynamic> row = {
  //     DatabaseHelper.columnName: name,
  //     DatabaseHelper.columnDose: dose,
  //     DatabaseHelper.medImgUrl:imgurl,
  //     DatabaseHelper.minute:1300,
  //     DatabaseHelper.time:selectedtime
  //   };
    // Fluttertoast.showToast(
    //   msg: "e.toString()",
    //   toastLength: Toast.LENGTH_LONG,
    //   gravity: ToastGravity.CENTER,
    //   timeInSecForIosWeb: 1,
    //   backgroundColor: Color(0Xff69bcfc),
    //   textColor: Colors.white,
    //   fontSize: 16.0,
    // );
  //   MyMedicineModel car = MyMedicineModel.fromMap(row);
  //  var id =await dbHelper.insert(car.toMap());
  //    Fluttertoast.showToast(
  //     msg: id.toString(),
  //     toastLength: Toast.LENGTH_LONG,
  //     gravity: ToastGravity.CENTER,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: Color(0Xff69bcfc),
  //     textColor: Colors.white,
  //     fontSize: 16.0,
  //   );
  }

class searchProductDropDown extends StatefulWidget {
  searchProductDropDown({Key? key}) : super(key: key);

  @override
  State<searchProductDropDown> createState() => _searchProductDropDownState();
}

class _searchProductDropDownState extends State<searchProductDropDown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 59,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("products").snapshots(),
          builder: (context, productsnapshot) {
            if (productsnapshot.connectionState == ConnectionState.waiting) {
              return TextFormField(
                initialValue: selectedPName,
                decoration: InputDecoration(
                    suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              );
            }
            pList.clear();
             pList = productsnapshot.data!.docs;

            return DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              items: pList.map((value) {
                return DropdownMenuItem<String>(
                  value: value['Name'],
                  child: Row(
                    children: [
                      Image.network(
                        value['Img'],
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(value['Name'].toString().length > 20
                          ? value['Name'].toString().substring(0, 20)
                          : value['Name'].toString()),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                selectedPName = value!;
              },
              onSaved: (value) {
                selectedPName = value!;
              },
              value: selectedPName.isNotEmpty ? selectedPName : null,
            );
          }),
    );
  }
}
