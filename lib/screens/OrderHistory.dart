import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medicines/models/search_medicine.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../bottom_nav/bottom_nav_bar.dart';

class OrderHistory extends StatefulWidget {
  OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

String? pho = "";

class _OrderHistoryState extends State<OrderHistory> {
 

 
  
  @override
  Widget build(BuildContext context) {
   getphone();
     
    return Scaffold(
      backgroundColor: Colors.white,
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
          "Order History",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16),
          child: Column(
            children: [
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(phone)
                          .collection("history")
                          .snapshots(),
                      builder: (context, productsnapshot) {
                        if (productsnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          var historyList=productsnapshot.data!.docs;
                          return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: ClampingScrollPhysics(),
                              itemCount: historyList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 140,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 80,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: !historyList[index]['status']?Color(0xFFFFE4E4):Colors.blue[50],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(7)),
                                            ),
                                            child: Center(
                                              child: Text(
                                               historyList[index]['status']? "Success":"Failed",
                                                style: TextStyle(
                                                    color: !historyList[index]['status']?Color(0xFFFF4C4C):Color.fromARGB(255, 53, 187, 232),
                                                    fontSize: 17),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "05-05-2022",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 132, 130, 130),
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "OrderId",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 132, 130, 130),
                                                    fontSize: 17),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                historyList[index]['status']?historyList[index]['orderid'].substring(0,11):"xxxxxxxxxxxx",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Deliver to",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 132, 130, 130),
                                                    fontSize: 17),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Home",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 13,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Total Payment",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 132, 130, 130),
                                                    fontSize: 17),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Rs "+historyList[index]['totalPayment'],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Divider(
                                        color:
                                            Color.fromARGB(255, 151, 153, 153),
                                        thickness: 1.0,
                                      ),
                                    ],
                                  ),
                                );
                              });
                        }
                      }))
            
            ],
          ),
        ),
      ),
    );
  }
  
}
getphone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    pho = await prefs.getString('phone_number');
  }