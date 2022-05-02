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
import 'package:medicines/screens/SearcResultScreen.dart';
import 'package:medicines/screens/product_details.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:google_ml_vision/google_ml_vision.dart';

class CategoryDetailsDart extends StatefulWidget {
  String category;
  CategoryDetailsDart({required this.category, Key? key}) : super(key: key);

  @override
  State<CategoryDetailsDart> createState() => _CategoryDetailsDartState();
}

var medList = [];

class _CategoryDetailsDartState extends State<CategoryDetailsDart> {
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
          widget.category,
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
                            medList.clear();
                            var plist = productsnapshot.data!.docs;

                            for (int i = 0; i < plist.length; i++) {
                              if (plist[i]['Medicine_type'] ==
                                  widget.category.toString()) {
                                medList.add(plist[i]);
                              }
                            }
                            return medList.length > 0
                                ? GridView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: medList.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisExtent: 204,
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CategoryDetailView(
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

class CategoryDetailView extends StatefulWidget {
  int index;
  CategoryDetailView({required this.index, Key? key}) : super(key: key);

  @override
  State<CategoryDetailView> createState() => _CategoryDetailViewState();
}

class _CategoryDetailViewState extends State<CategoryDetailView> {
  
  @override
  Widget build(BuildContext context) {
      
    String image = medList[widget.index]['Img'];
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                    index: widget.index,
                    pid: medList[widget.index].id.toString(),
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
                          medList[widget.index]['Name'].length > 9
                              ? medList[widget.index]['Name'].substring(0, 7) +
                                  "..."
                              : medList[widget.index]['Name'],
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
                          medList[widget.index]['For'].length > 16
                              ? medList[widget.index]['For'].substring(0, 16) +
                                  "..."
                              : medList[widget.index]['For'],
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
                          medList[widget.index]['Medicine_is'],
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
                          medList[widget.index]['Company_name'].length > 13
                              ? medList[widget.index]['Company_name']
                                      .substring(0, 13) +
                                  "..."
                              : medList[widget.index]['Company_name'],
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
