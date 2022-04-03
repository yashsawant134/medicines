import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medicines/bottom_nav/bottom_nav_bar.dart';
import 'package:medicines/models/search_medicine.dart';
import 'package:medicines/screens/product_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

String? phone;

var favList = [];

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    getPhoneNo();

    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(phone)
                .collection("favourite")
                .snapshots(),
            builder: (context, productsnapshot) {
                              

              if (productsnapshot.connectionState == ConnectionState.waiting) {
               
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                 favList = productsnapshot.data!.docs;
                return favList.length>0?ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: favList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                      index: index,
                                      pid: favList[index]['product_id'],
                                    )),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.05,
                              height: 135,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(19))),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 0, top: 5, bottom: 8),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 130,
                                      height: 130,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF82C6FB)
                                              .withOpacity(0.14),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Center(
                                        child: new Image.network(
                                          favList[index]['img'],
                                          width: 70,
                                          height: 70,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            favList[index]['p_name'],
                                            style: GoogleFonts.lato(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Text(
                                            favList[index]['company_name'],
                                            style: GoogleFonts.lato(
                                              fontSize: 18,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Rs. " +
                                                    favList[index]['price']
                                                        .toString(),
                                                style: GoogleFonts.lato(
                                                  fontSize: 18,
                                                  color: Colors.blue[300],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 110,
                                              ),
                                              ClipOval(
                                                  child: Material(
                                                color:
                                                    Colors.red, // Button color
                                                child: InkWell(
                                                  splashColor: Colors
                                                      .white, // Splash color
                                                  onTap: () {
                                                     FirebaseFirestore.instance
                                                        .collection("users")
                                                        .doc(phone)
                                                        .collection("favourite")
                                                        .doc(favList[index]['product_id'])
                                                        .delete();
                                                  },
                                                  child: SizedBox(
                                                    width: 27,
                                                    height: 27,
                                                    child: Icon(
                                                      Icons.favorite,
                                                      color: Colors.white,
                                                      size: 19,
                                                    ),
                                                  ),
                                                ),
                                              ))
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }):Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.white,
                      child: Center(
                        child: Image.network("https://ruseller.com/lessons/les2595/images/37-empty-state-mobile-app-designs.jpg",width: 700,height:700,),
                      ),
                    );
              }
            }));
  }
}

void getPhoneNo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  phone = prefs.getString('phone_number');
}
