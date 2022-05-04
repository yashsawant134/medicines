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

import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class AddAddress extends StatefulWidget {
  AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}



String postcode="";
String address="";
 
class _AddAddressState extends State<AddAddress> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
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
            "Add Address",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("users").snapshots(),
            builder: (context, usersnapshot) {
              if (usersnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var userList = usersnapshot.data!.docs;
                var user;
                for (int i = 0; i < userList.length; i++) {
                  if (userList[i].id == phone) {
                    user = userList[i];
                  }
                }
                TextEditingController postalcontroller = new TextEditingController(text:  user['postalcode']);
   TextEditingController  addresscontroller = new TextEditingController(text:  user['address']);
                return SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0, left: 16),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text(
                                "Add your\nDelivery Address!",
                                style: GoogleFonts.lato(
                                    fontWeight: FontWeight.w600, fontSize: 32),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Image.asset(
                            "assets/png/delivery.png",
                            width: 190,
                            height: 190,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Text(
                                "Postal Code :",
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 22),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: postalcontroller,
                           
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: 'Postal code',
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Address :",
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 22),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: addresscontroller,
                            
                            keyboardType: TextInputType.multiline,
                            maxLines: 10,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: 'Delivery Address',
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          InkWell(
                            onTap: () {
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(phone)
                                  .update({
                                'postalcode': postalcontroller.text,
                                'address': addresscontroller.text
                              }).then((_) => Fluttertoast.showToast(
                                        msg: "Added Successfully",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Color(0Xff69bcfc),
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      ));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 9,
                                    color: Color(0Xff69bcfc).withOpacity(0.5),
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF82C6FB),
                                    Color(0XFF69BCFC)
                                  ],
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Update my Address",
                                    style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }));
  }
}
