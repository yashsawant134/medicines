import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicines/bottom_nav/bottom_nav_bar.dart';
import 'package:medicines/models/search_medicine.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:medicines/modules/MyMedicineModel.dart';
import 'package:medicines/modules/search_medicines_layout.dart';
import 'package:medicines/screens/AddScreens.dart';
import 'package:medicines/screens/home.dart';
import 'package:medicines/screens/product_details.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:google_ml_vision/google_ml_vision.dart';

class SearchResultScreen extends StatefulWidget {
  String searchword;
  SearchResultScreen({required this.searchword, Key? key}) : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

var medsList = [];

class _SearchResultScreenState extends State<SearchResultScreen> {
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
          "Upload Prescription",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: Column(children: [
                Expanded(
                  child: Container(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("products")
                            .snapshots(),
                        builder: (context, productsnapshot) {
                          if (productsnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            medsList.clear();
                            var searchMeds = productsnapshot.data!.docs;
                            List<String> searchString =
                                widget.searchword.toLowerCase().split("\n");
                            for(int i=0;i<searchString.length;i++){
                              // Fluttertoast.showToast(
                              //     msg: searchString[i],
                              //     toastLength: Toast.LENGTH_LONG,
                              //     gravity: ToastGravity.CENTER,
                              //     timeInSecForIosWeb: 1,
                              //     backgroundColor: Color(0Xff69bcfc),
                              //     textColor: Colors.white,
                              //     fontSize: 16.0,
                              //   );
                            }
                            for (int i = 0; i < searchMeds.length; i++) {
                              String s = searchMeds[i]['Name'].toLowerCase();
                              List<String> l = s.trim().split(" ");
                          
                              for (int j = 0; j < l.length; j++) {
                                
                                if (searchString.contains(l[j])) {
                                  medsList.add(searchMeds[i]);
                                  break;
                                }
                              }
                            }

                            return medsList.length > 0
                                ? GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: medsList.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisExtent: 204,
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return SearchMedicineLayou(
                                        index: index,
                                      );
                                    })
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: Center(
                                      child: Text("Sorry we can't find :_("),
                                    ),
                                  );
                          }
                        }),
                  ),
                )
              ]))),
    );
  }
}

class SearchMedicineLayou extends StatefulWidget {
  int index;

  SearchMedicineLayou({Key? key, required this.index}) : super(key: key);

  @override
  _SearchMedicineLayouState createState() => _SearchMedicineLayouState();
}

class _SearchMedicineLayouState extends State<SearchMedicineLayou> {
  @override
  Widget build(BuildContext context) {
    String image = medsList[widget.index]['Img'];
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                    index: widget.index,
                    pid: medsList[widget.index].id.toString(),
                  )),
        );
      },
      child: Container(
        // width: MediaQuery.of(context).size.width/2.5,
        height: 160,
        decoration: BoxDecoration(
            color: Color(0xFF82C6FB).withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(15))),

        child: Padding(
          padding: const EdgeInsets.only(top: 7, left: 8, right: 8, bottom: 2),
          child: Column(
            children: [
              Container(
                width: 135,
                height: 85,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Center(
                    child: Hero(
                  tag: "detailImage" + widget.index.toString(),
                  child: new Image.network(
                    image,
                    height: 70,
                    width: 85,
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          medsList[widget.index]['Name'].length > 6
                              ? medsList[widget.index]['Name'].substring(0, 6) +
                                  "..."
                              : medsList[widget.index]['Name'],
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w400, fontSize: 19),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "(" + searchMedicineList[widget.index].intake + ")",
                          style: GoogleFonts.lato(
                              fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          medsList[widget.index]['For'].length > 14
                              ? medsList[widget.index]['For'].substring(0, 14) +
                                  "..."
                              : medsList[widget.index]['For'],
                          style: GoogleFonts.lato(
                              color: Colors.grey[600], fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Text(
                          medsList[widget.index]['Medicine_is'],
                          style:
                              GoogleFonts.lato(color: Colors.deepOrange[400]),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Text(
                          medsList[widget.index]['Company_name'].length > 10
                              ? medsList[widget.index]['Company_name']
                                      .substring(0, 10) +
                                  "..."
                              : medsList[widget.index]['Company_name'],
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF82C6FB),
                            fontSize: 18,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
