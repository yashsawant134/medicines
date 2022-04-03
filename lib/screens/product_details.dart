import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicines/models/search_medicine.dart';
import 'package:medicines/screens/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int index;
  final String pid;

  const ProductDetailsScreen({Key? key, required this.index, required this.pid})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

bool isAddedToFavourite = false;
int qty = 1;
int finalprice = 0;
String phone = "";
String name = "";
String forwhat = "";
String Medicine_is = "";
String company_name = "";
String indication = "";
String img = "";
int price = 0;
@override
void initState() {
  // TODO: implement initState
  isAddedToFavourite = false;
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget.pid.toString());
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection("products")
          .doc(widget.pid)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16, top: 15),
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/png/shopping_cart.png",
                      width: 28,
                      height: 28,
                    ),
                  ),
                )
              ],
              leading: InkWell(
                onTap: () {
                  finalprice = 0;
                  isAddedToFavourite = false;
                  Navigator.maybePop(context);
                },
                child: Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.black54,
                ),
              ),
              title: Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    "Product Details",
                    style: GoogleFonts.lato(color: Colors.black),
                  )),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white.withOpacity(0.6),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, top: 0, bottom: 0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          children: <Widget>[
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 2.5,
                              decoration: BoxDecoration(
                                  color: Color(0Xff69bcfc).withOpacity(0.08),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: Center(
                                child: Container(
                                  margin: EdgeInsets.only(right: 30, left: 30),
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            top: 0,
                                            right: 0,
                                            child: FutureBuilder(
                                                future:
                                                    isAlreadyTheirInFavourite(
                                                        widget.pid),
                                                builder: (context,
                                                    AsyncSnapshot<
                                                            DocumentSnapshot>
                                                        snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.done) {
                                                    return snapshot.data!.exists
                                                        ? ClipOval(
                                                            child: Material(
                                                              color: Color(
                                                                      0Xff69bcfc)
                                                                  .withOpacity(
                                                                      0.3), // Button color
                                                              child: InkWell(
                                                                splashColor: Colors
                                                                    .white, // Splash color
                                                                onTap: () {},
                                                                child: SizedBox(
                                                                    width: 46,
                                                                    height: 46,
                                                                    child: Icon(
                                                                        Icons
                                                                            .favorite,
                                                                        color: Colors
                                                                            .red)),
                                                              ),
                                                            ),
                                                          )
                                                        : ClipOval(
                                                            child: Material(
                                                              color: Color(
                                                                      0Xff69bcfc)
                                                                  .withOpacity(
                                                                      0.3), // Button color
                                                              child: InkWell(
                                                                splashColor: Colors
                                                                    .white, // Splash color
                                                                onTap: () {},
                                                                child: SizedBox(
                                                                    width: 46,
                                                                    height: 46,
                                                                    child: Icon(
                                                                        Icons
                                                                            .favorite_border)),
                                                              ),
                                                            ),
                                                          );
                                                    ;
                                                  } else {
                                                    return ClipOval(
                                                      child: Material(
                                                        color: Color(0Xff69bcfc)
                                                            .withOpacity(
                                                                0.3), // Button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .white, // Splash color
                                                          onTap: () {},
                                                          child: SizedBox(
                                                              width: 46,
                                                              height: 46,
                                                              child: Icon(Icons
                                                                  .favorite_border)),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                })),
                                        Positioned.fill(
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                    width: 150,
                                                    height: 150,
                                                    child: Hero(
                                                        tag: "detailImage" +
                                                            widget.index
                                                                .toString(),
                                                        child:
                                                            new Image.network(
                                                                img)))))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  name,
                                  style: GoogleFonts.lato(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 9,
                                ),
                                Text(
                                  "(120 mg)",
                                  style: GoogleFonts.lato(
                                      fontSize: 16, color: Colors.grey),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(Medicine_is,
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      color: Colors.deepOrangeAccent,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(forwhat,
                                style: GoogleFonts.lato(
                                  color: Colors.grey[500],
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                )),
                            SizedBox(
                              height: 6,
                            ),
                            Text(company_name,
                                style: GoogleFonts.lato(
                                  color: Color(0Xff69bcfc),
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Unit price :   Rs " +
                                    price.toString() +
                                    ".00 ",
                                style: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Indication",
                                style: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            Text(indication,
                                style: GoogleFonts.lato(
                                  color: Color.fromARGB(255, 108, 107, 107),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ))
                          ]),
                    )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              width: double.infinity,
              height: 190,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0Xff69bcfc).withOpacity(0.5),
                      blurRadius: 9,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 30, right: 30, bottom: 20),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Quantity  :",
                          style: GoogleFonts.lato(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 140,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF82C6FB), Color(0XFF69BCFC)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0Xff69bcfc).withOpacity(0.5),
                                blurRadius: 9.0,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (qty < 10) qty++;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  )),
                              Text(
                                qty.toString(),
                                style: GoogleFonts.lato(
                                    fontSize: 21,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (qty > 1) {
                                        qty--;
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      margin: EdgeInsets.only(left: 0, right: 0, top: 25),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF82C6FB).withOpacity(0.14),
                                Color(0XFF69BCFC).withOpacity(0.14)
                              ]),
                          borderRadius: BorderRadius.all(Radius.circular(21))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Rs ${qty * finalprice}",
                                style: GoogleFonts.lato(
                                    color: const Color(0xFF82C6FB),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 65,
                                height: 65,
                                decoration: BoxDecoration(
                                    color: Color(0xff82c6fb),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(17))),
                                child: Center(
                                  child: new Image.asset(
                                    "assets/png/shopping_cart.png",
                                    color: Colors.white,
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          finalprice = data['Price'];
          name = data['Name'];
          forwhat = data['For'];
          img = data['Img'];
          indication = data['Indication'];
          Medicine_is = data['Medicine_is'];
          price = data['Price'];
          company_name = data['Company_name'];
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16, top: 15),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddToCart(
                                  phoneNumber: phone,
                                )),
                      );
                    },
                    icon: Image.asset(
                      "assets/png/shopping_cart.png",
                      width: 28,
                      height: 28,
                    ),
                  ),
                )
              ],
              leading: InkWell(
                onTap: () {
                  finalprice = 0;
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.black54,
                ),
              ),
              title: Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    "Product Details",
                    style: GoogleFonts.lato(color: Colors.black),
                  )),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white.withOpacity(0.6),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, top: 0, bottom: 0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          children: <Widget>[
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 2.5,
                              decoration: BoxDecoration(
                                  color: Color(0Xff69bcfc).withOpacity(0.08),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: Center(
                                child: Container(
                                  margin: EdgeInsets.only(right: 30, left: 30),
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            top: 0,
                                            right: 0,
                                            child: FutureBuilder(
                                                future:
                                                    isAlreadyTheirInFavourite(
                                                        widget.pid),
                                                builder: (context,
                                                    AsyncSnapshot<
                                                            DocumentSnapshot>
                                                        snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.done) {
                                                    return snapshot.data!.exists
                                                        ? ClipOval(
                                                            child: Material(
                                                              color: Color(
                                                                      0Xff69bcfc)
                                                                  .withOpacity(
                                                                      0.3), // Button color
                                                              child: InkWell(
                                                                splashColor: Colors
                                                                    .white, // Splash color
                                                                onTap: () {},
                                                                child: SizedBox(
                                                                    width: 46,
                                                                    height: 46,
                                                                    child: Icon(
                                                                        Icons
                                                                            .favorite,
                                                                        color: Colors
                                                                            .red)),
                                                              ),
                                                            ),
                                                          )
                                                        : ClipOval(
                                                            child: Material(
                                                              color: Color(
                                                                      0Xff69bcfc)
                                                                  .withOpacity(
                                                                      0.3), // Button color
                                                              child: InkWell(
                                                                splashColor: Colors
                                                                    .white, // Splash color
                                                                onTap: () {
                                                                  addToFavourite(widget.pid);
                                                                  setState(() {
                                                                    
                                                                  });
                                                                },
                                                                child: SizedBox(
                                                                    width: 46,
                                                                    height: 46,
                                                                    child: Icon(
                                                                        Icons
                                                                            .favorite_border)),
                                                              ),
                                                            ),
                                                          );
                                                  } else {
                                                    return ClipOval(
                                                      child: Material(
                                                        color: Color(0Xff69bcfc)
                                                            .withOpacity(
                                                                0.3), // Button color
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .white, // Splash color
                                                          onTap: () {},
                                                          child: SizedBox(
                                                              width: 46,
                                                              height: 46,
                                                              child: Icon(Icons
                                                                  .favorite_border)),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                })),
                                        Positioned.fill(
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                    width: 150,
                                                    height: 150,
                                                    child: Hero(
                                                        tag: "detailImage" +
                                                            widget.index
                                                                .toString(),
                                                        child:
                                                            new Image.network(
                                                                data['Img'])))))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  data['Name'].length > 23
                                      ? data['Name'].substring(0, 18) + "..."
                                      : data['Name'],
                                  style: GoogleFonts.lato(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 9,
                                ),
                                Text(
                                  "(120 mg)",
                                  style: GoogleFonts.lato(
                                      fontSize: 16, color: Colors.grey),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(data['Medicine_is'],
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      color: Colors.deepOrangeAccent,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(data['For'],
                                style: GoogleFonts.lato(
                                  color: Colors.grey[500],
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                )),
                            SizedBox(
                              height: 6,
                            ),
                            Text(data['Company_name'],
                                style: GoogleFonts.lato(
                                  color: Color(0Xff69bcfc),
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Unit price :   Rs " +
                                    data['Price'].toString() +
                                    ".00 ",
                                style: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Indication",
                                style: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            Text(data['Indication'],
                                style: GoogleFonts.lato(
                                  color: Color.fromARGB(255, 108, 107, 107),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ))
                          ]),
                    )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              width: double.infinity,
              height: 190,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0Xff69bcfc).withOpacity(0.5),
                      blurRadius: 9,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 30, right: 30, bottom: 20),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Quantity  :",
                          style: GoogleFonts.lato(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 140,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF82C6FB), Color(0XFF69BCFC)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0Xff69bcfc).withOpacity(0.5),
                                blurRadius: 9.0,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (qty < 10) qty++;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  )),
                              Text(
                                qty.toString(),
                                style: GoogleFonts.lato(
                                    fontSize: 21,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (qty > 1) {
                                        qty--;
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      margin: EdgeInsets.only(left: 0, right: 0, top: 25),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF82C6FB).withOpacity(0.14),
                                Color(0XFF69BCFC).withOpacity(0.14)
                              ]),
                          borderRadius: BorderRadius.all(Radius.circular(21))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Rs ${qty * finalprice}",
                                style: GoogleFonts.lato(
                                    color: const Color(0xFF82C6FB),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                            GestureDetector(
                              onTap: () {
                                checkIfProductAlreadyExistInCart(
                                    widget.pid,
                                    context,
                                    data['Img'],
                                    data['For'],
                                    data['Name'],
                                    data['Price']);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddToCart(
                                            phoneNumber: phone,
                                          )),
                                );
                              },
                              child: Container(
                                width: 65,
                                height: 65,
                                decoration: BoxDecoration(
                                    color: Color(0xff82c6fb),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(17))),
                                child: Center(
                                  child: new Image.asset(
                                    "assets/png/shopping_cart.png",
                                    color: Colors.white,
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

getPhonenumber() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? phone_number = prefs.getString('phone_number');
  phone = phone_number!;
  return phone_number;
}

void addToFavourite(String pid) async {
  try {
    String phoneno = await getPhonenumber();
    var collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(phoneno)
        .collection('favourite');

    var doc = await collectionRef.doc(pid).get();

    if (!doc.exists) {
      collectionRef.doc(pid).set({
        'product_id': pid,
        'p_name': name,
        'price': price,
        'img': img,
        'company_name': company_name
      });

      isAddedToFavourite = false;
    } else {
      isAddedToFavourite = true;
    }
  } catch (e) {
    Fluttertoast.showToast(
      msg: e.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0Xff69bcfc),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

Future<DocumentSnapshot> isAlreadyTheirInFavourite(String pid) async {
  String phoneno = await getPhonenumber();
  var collectionRef = FirebaseFirestore.instance
      .collection('users')
      .doc(phoneno)
      .collection('favourite');

  var doc = await collectionRef.doc(pid).get();
  return doc;
}

void checkIfProductAlreadyExistInCart(String docId, BuildContext context,
    String img, String _for, String name, int price) async {
  try {
    // Get reference to Firestore collection
    String phone_number = await getPhonenumber();
    var collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(phone_number)
        .collection('cart');

    var doc = await collectionRef.doc(docId).get();

    if (!doc.exists) {
      collectionRef.doc(docId).set({
        'product_id': docId,
        'qty': qty,
        'img': img,
        'for': _for,
        'name': name,
        'price': price
      });
    }
  } catch (e) {
    Fluttertoast.showToast(
      msg: e.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0Xff69bcfc),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

















//  return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 16, top: 15),
//             child: IconButton(
//               onPressed: () {},
//               icon: Image.asset(
//                 "assets/png/shopping_cart.png",
//                 width: 28,
//                 height: 28,
//               ),
//             ),
//           )
//         ],
//         leading: InkWell(
//           onTap: () {
//             finalprice=0;
//             Navigator.pop(context);
//           },
//           child: Icon(
//             Icons.arrow_back_sharp,
//             color: Colors.black54,
//           ),
//         ),
//         title: Container(
//             margin: EdgeInsets.only(top: 15),
//             child: Text(
//               "Product Details",
//               style: GoogleFonts.lato(color: Colors.black),
//             )),
//       ),
//       body: FutureBuilder<DocumentSnapshot>(
//         future: FirebaseFirestore.instance
//             .collection("products")
//             .doc(widget.pid)
//             .get(),
//         builder:
//             (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Text("Something went wrong");
//           }

//           if (snapshot.hasData && !snapshot.data!.exists) {
//             return Text("Document does not exist");
//           }

//           if (snapshot.connectionState == ConnectionState.done) {
//             Map<String, dynamic> data =
//                 snapshot.data!.data() as Map<String, dynamic>;
            
//             finalprice =data['price'];
//             return Container(
//               width: MediaQuery.of(context).size.width,
//               color: Colors.white.withOpacity(0.6),
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                     right: 20, left: 20, top: 0, bottom: 0),
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: ListView(
//                           shrinkWrap: true,
//                           physics: BouncingScrollPhysics(),
//                           children: <Widget>[
//                             SizedBox(
//                               height: 15,
//                             ),
//                             Container(
//                               width: MediaQuery.of(context).size.width,
//                               height: MediaQuery.of(context).size.height / 2.5,
//                               decoration: BoxDecoration(
//                                   color: Color(0Xff69bcfc).withOpacity(0.08),
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(30))),
//                               child: Center(
//                                 child: Container(
//                                   margin: EdgeInsets.only(right: 30, left: 30),
//                                   height:
//                                       MediaQuery.of(context).size.height / 3,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(25))),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Stack(
//                                       children: [
//                                         Positioned(
//                                             top: 0,
//                                             right: 0,
//                                             child: ClipOval(
//                                               child: Material(
//                                                 color: Color(0Xff69bcfc)
//                                                     .withOpacity(
//                                                         0.3), // Button color
//                                                 child: InkWell(
//                                                   splashColor: Colors
//                                                       .white, // Splash color
//                                                   onTap: () {},
//                                                   child: SizedBox(
//                                                       width: 46,
//                                                       height: 46,
//                                                       child: Icon(Icons
//                                                           .favorite_border)),
//                                                 ),
//                                               ),
//                                             )),
//                                         Positioned.fill(
//                                             child: Align(
//                                                 alignment: Alignment.center,
//                                                 child: Container(
//                                                     width: 150,
//                                                     height: 150,
//                                                     child: Hero(
//                                                         tag: "detailImage" +
//                                                             widget.index
//                                                                 .toString(),
//                                                         child:
//                                                             new Image.network(
//                                                                 data['img'])))))
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 15,
//                             ),
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   data['name'],
//                                   style: GoogleFonts.lato(
//                                       fontSize: 24,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 SizedBox(
//                                   width: 9,
//                                 ),
//                                 Text(
//                                   "(120 mg)",
//                                   style: GoogleFonts.lato(
//                                       fontSize: 16, color: Colors.grey),
//                                 ),
//                                 SizedBox(
//                                   width: 8,
//                                 ),
//                                 Text(data['Medicine_is'],
//                                     style: GoogleFonts.lato(
//                                       fontSize: 16,
//                                       color: Colors.deepOrangeAccent,
//                                     ))
//                               ],
//                             ),
//                             SizedBox(
//                               height: 6,
//                             ),
//                             Text(data['for'],
//                                 style: GoogleFonts.lato(
//                                   color: Colors.grey[500],
//                                   fontSize: 19,
//                                   fontWeight: FontWeight.w500,
//                                 )),
//                             SizedBox(
//                               height: 6,
//                             ),
//                             Text(data['company_name'],
//                                 style: GoogleFonts.lato(
//                                   color: Color(0Xff69bcfc),
//                                   fontSize: 19,
//                                   fontWeight: FontWeight.w500,
//                                 )),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                                 "Unit price :   Rs " +
//                                     data['price'].toString() +
//                                     ".00 ",
//                                 style: GoogleFonts.lato(
//                                   color: Colors.black,
//                                   fontSize: 19,
//                                   fontWeight: FontWeight.bold,
//                                 )),
//                             SizedBox(
//                               height: 8,
//                             ),
//                             Text("Indication",
//                                 style: GoogleFonts.lato(
//                                   color: Colors.black,
//                                   fontSize: 19,
//                                   fontWeight: FontWeight.bold,
//                                 )),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text(data['indication'],
//                                 style: GoogleFonts.lato(
//                                   color: Color.fromARGB(255, 108, 107, 107),
//                                   fontSize: 17,
//                                   fontWeight: FontWeight.w500,
//                                 ))
//                           ]),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           }

//           return Center(child: CircularProgressIndicator());
//         },
//       ),
//       bottomNavigationBar: Container(
//         width: double.infinity,
//         height: 190,
//         decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Color(0Xff69bcfc).withOpacity(0.5),
//                 blurRadius: 9,
//               ),
//             ],
//             borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(20), topLeft: Radius.circular(20))),
//         child: Padding(
//           padding:
//               const EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 20),
//           child: Column(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Quantity  :",
//                     style: GoogleFonts.lato(
//                         fontSize: 24,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Container(
//                     width: 140,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(15)),
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [Color(0xFF82C6FB), Color(0XFF69BCFC)],
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color(0Xff69bcfc).withOpacity(0.5),
//                           blurRadius: 9.0,
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 if (qty < 10) qty++;
//                               });
//                             },
//                             icon: Icon(
//                               Icons.add,
//                               color: Colors.white,
//                             )),
//                         Text(
//                           qty.toString(),
//                           style: GoogleFonts.lato(
//                               fontSize: 21,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 if (qty > 1) {
//                                   qty--;
//                                 }
//                               });
//                             },
//                             icon: Icon(
//                               Icons.remove,
//                               color: Colors.white,
//                             )),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: 80,
//                 margin: EdgeInsets.only(left: 0, right: 0, top: 25),
//                 decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           Color(0xFF82C6FB).withOpacity(0.14),
//                           Color(0XFF69BCFC).withOpacity(0.14)
//                         ]),
//                     borderRadius: BorderRadius.all(Radius.circular(21))),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 16, right: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Rs ${qty * finalprice}",
//                           style: GoogleFonts.lato(
//                               color: const Color(0xFF82C6FB),
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold)),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => AddToCart()),
//                           );

//                           checkIfProductAlreadyExistInCart(widget.pid, context);
//                         },
//                         child: Container(
//                           width: 65,
//                           height: 65,
//                           decoration: BoxDecoration(
//                               color: Color(0xff82c6fb),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(17))),
//                           child: Center(
//                             child: new Image.asset(
//                               "assets/png/shopping_cart.png",
//                               color: Colors.white,
//                               width: 30,
//                               height: 30,
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
  