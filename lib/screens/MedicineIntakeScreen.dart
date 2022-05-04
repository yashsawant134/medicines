import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medicines/bottom_nav/bottom_nav_bar.dart';
import 'package:medicines/models/search_medicine.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:medicines/modules/MyMedicineModel.dart';
import 'package:medicines/screens/AddScreens.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';


class MedicineIntakeScreen extends StatefulWidget {
  MedicineIntakeScreen({Key? key}) : super(key: key);

  @override
  State<MedicineIntakeScreen> createState() => _MedicineIntakeScreenState();
}

var monthsList = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];
var now = new DateTime.now();
var formatter = DateFormat('MM');
String stringMonth = formatter.format(now);
int monthIndex = int.parse(stringMonth);
List<MyMedicineModel> mymedicinel=[];
int? allRows=1;

var curminFormatter=DateFormat('HH:mm');
String curmin=curminFormatter.format(now);
int curminINT=0;
class _MedicineIntakeScreenState extends State<MedicineIntakeScreen> {
  @override
void initState() {
  super.initState();
  getMeds().then((data) {
      
    });
}

  Future getMeds() async{
   allRows = await dbHelper.queryRowCount();
   
    mymedicinel.clear();
    final all=await dbHelper.queryAllRows();
   return all.forEach((row) => mymedicinel.add(MyMedicineModel.fromMap(row)));
    // allRows.forEach((row) => mymedicinel.add(MyMedicineModel.fromMap(row)));
  }

  @override
  Widget build(BuildContext context) {
     curminINT=(int.parse(curmin.substring(0,2))*60) + int.parse(curmin.substring(3,5));

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
            "Medicine",
            style: TextStyle(color: Colors.black),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // isExtended: true,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Color(0xFF69BCFC),
          onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddScreens(
                            
                          )),
                );
          },
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: Color(0xFFFAFAFA),
          child: Column(
            children: [
              Expanded(
                  child: ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 45,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 12,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.all(6),
                                  width: 65,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: monthIndex - 1 == index
                                          ? Color(0xFFF898B4)
                                          : Color.fromARGB(255, 246, 246, 246)),
                                  child: Center(
                                    child: Text(
                                      monthsList[index],
                                      style: TextStyle(
                                          color: monthIndex - 1 == index
                                              ? Colors.white
                                              : Colors.grey,
                                          fontSize: 17),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: IgnorePointer(
                            child: DatePicker(
                              
                              DateTime.now(),
                              daysCount: 7,
                              initialSelectedDate: DateTime.now(),
                              selectionColor: Color(0xFF74C1FA),
                              width: 60,
                              monthTextStyle: TextStyle(
                                  color: Colors.transparent, fontSize: 0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                   StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("users").doc(phone).collection("mymedicine").snapshots(),
            builder: (context, usersnapshot) {
              if (usersnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var medL=usersnapshot.data!.docs;
               
                var queue = PriorityQueue<medListSortedData>((a, b) => int.parse(a.time!.substring(0,2))-int.parse(b.time!.substring(0,2)));
                List<medListSortedData> medList=[];
                
                for(int i=0;i<medL.length;i++){
                  medListSortedData m1=new medListSortedData(medL[i]['medImgUrl'], medL[i]['med_name'], medL[i]['time'], medL[i]['minutes'], medL[i]['dose'],medL[i].id);
                  queue.add(m1);
                }
                int queueLength=queue.length;
                for(int i=0;i<queueLength;i++){
                  medList.add(queue.removeFirst());
                }
                  return   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          child: Expanded(
                            child: Column(
                              children: [
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: medList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onDoubleTap: (){
                                                                FirebaseFirestore.instance.collection("users").doc(phone).collection("mymedicine").doc(medList[index].id).delete();

                                        },
                                        child: Container(
                                            height: 110,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(int.parse(medList[index].time.toString().substring(0,2))>=12?medList[index].time.toString()+"\nPM":medList[index].time.toString()+"\nAM"),
                                              ],
                                            )),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 15,
                          child: Expanded(
                            child: Column(
                              children: [
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: medList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        child: Column(
                                          children: [
                                            index != 0
                                                ? Container(
                                                    height: 50,
                                                    child: VerticalDivider(
                                                      color: Color.fromARGB(255, 227, 236, 242),
                                                      thickness: 2,
                                                    ),
                                                  )
                                                : Container(),
                                            Container(
                                              width: 10,
                                              height: 10,
                                              decoration: new BoxDecoration(
                                                color: Color(0xFF73C0FB),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            index != medList.length-1
                                                ? Container(
                                                    height: 50,
                                                    child: VerticalDivider(
                                                      color: Color.fromARGB(255, 227, 236, 242),
                                                      thickness: 2,
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: Column(
                            children: [
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: medList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onDoubleTap: (){
                                                                FirebaseFirestore.instance.collection("users").doc(phone).collection("mymedicine").doc(medList[index].id).delete();

                                        },
                                      child: Container(
                                        width: 150,
                                        height: 110,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 95,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                border: Border.all(
                                                    color: Color(0xFF74C1FA)),
                                                color: Colors.white),
                                                      
                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 10,),
                                                    Container(
                                                      width: 70,
                                                      height: 70,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                                        color: Color(0xFFF2F9FF),
                                                      ),
                                                      child: Center(
                                                        child: Image.network(medList[index].medImgUrl!,width: 50,height: 50,),
                                                      ),
                                                      
                                                    ),
                                                     SizedBox(width: 20,),
                                                     Column(
                                                       mainAxisAlignment: MainAxisAlignment.center,
                                                       crossAxisAlignment: CrossAxisAlignment.start,
                                                       children: [
                                                         Text(medList[index].med_name!.length>=11?medList[index].med_name!.substring(0,9):medList[index].med_name!,style:TextStyle(color:Colors.black,fontSize: 21,fontWeight: FontWeight.bold)),
                                                         SizedBox(height: 4,),
                                                         Text("(10 mg)",style:TextStyle(color:Colors.grey,fontSize: 16)),
                                                       ],
                                                     ),
                                                     SizedBox(width: 40,),
                                                      
                                                    (int.parse(medList[index].time.toString().substring(0,2))*60) + int.parse(medList[index].time.toString().substring(3,5))<curminINT? Icon(Icons.check_circle_rounded,color:Colors.lightGreenAccent,size: 30,):Container()
                                                  ],
                                                ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                
              }}),
                ],
              ))
            ],
          ),
        ));
     
  }
}

class medListSortedData{
  String? medImgUrl,med_name,time,id;
  int? minutes,dose;
  medListSortedData(String medImgUrl,String med_name,String time,int minutes,int dose,String id){
    this.medImgUrl=medImgUrl;
    this.med_name=med_name;
    this.minutes=minutes;
    this.dose=dose;
    this.id=id;
    this.time=time;
  }
}