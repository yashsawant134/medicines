import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicines/models/category_model.dart';
import 'package:medicines/models/search_medicine.dart';
import 'package:medicines/modules/search_medicines_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medicines/screens/UploadPrescription.dart';
import 'package:medicines/screens/cart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var productList = [];
var newList = [];

var docidList = [];
String searchWord = "";

TextEditingController searchController = new TextEditingController();
changeSearchWord(String val) {
  searchWord = val;
}

class _HomeScreenState extends State<HomeScreen> {
  int current = 0;
  void changeCurrent(int n) {
    setState(() {
      newList.clear();
      productList.clear();
      current = n;
    });
  }

  @override
  Widget build(BuildContext context) {
    newList.clear();
    
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 23, right: 16, top: 26),
                        child: Row(
                          children: [
                            Text(
                              "Order your\nDesire Medicine!",
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w600, fontSize: 32),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 26),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Flexible(
                                  flex: 1,
                                  child: TextField(
                                    controller: searchController,
                                    onChanged: (value) {
                                      setState(() {
                                        changeSearchWord(value);
                                      });
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.search,
                                          color: Color(0xFF69BCFC),
                                          size: 30,
                                        ),
                                        filled: true,
                                        fillColor:
                                            Color(0xFF69BCFC).withOpacity(0.07),
                                        hintText: "Search",
                                        hintStyle: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w300),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 14.0,
                                                horizontal: 20.0),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: const BorderSide(
                                              color: Color(0xFF69BCFC),
                                              width: 0.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: const BorderSide(
                                              color: Color(0xFF69BCFC),
                                              width: 1.0),
                                        )),
                                  )),
                              SizedBox(
                                width: 7,
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      UploadPrescription()));
                                },
                                child: Flexible(
                                  flex: 0,
                                  child: Container(
                                    width: 50,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF69BCFC).withOpacity(0.9),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Center(
                                      child: new Image.asset(
                                        "assets/png/upload.png",
                                        height: 31,
                                        width: 31,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: searchWord.length == 0,
                        child: Container(
                          margin: EdgeInsets.only(top: 23, left: 20),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Categories",
                                    style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 24),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: searchWord.length == 0,
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 43,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 3,
                              itemBuilder: (BuildContext context, int index) {
                                return CategoriesList(
                                  index: index,
                                  isSelected: current == index,
                                  changeCurrent: changeCurrent,
                                );
                              }),
                        ),
                      ),
                      Visibility(
                        visible: searchWord.length == 0,
                        child: Container(
                            margin:
                                EdgeInsets.only(top: 30, left: 17, right: 17),
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
                                    productList = productsnapshot.data!.docs;
                                    int j = 0;
                                    for (int i = 0;
                                        i < productList.length;
                                        i++) {
                                      if (productList[i]['Medicine_type'] ==
                                          categoriesList[current].name) {
                                        newList.insert(j, productList[i]);
                                        docidList.insert(j,
                                            productsnapshot.data!.docs[i].id);
                                      }
                                    }
                                    return GridView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: newList.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisExtent: 204,
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return SearchMedicineLayout(
                                            index: index,
                                          );
                                        });
                                  }
                                })),
                      ),
                      Visibility(
                        visible: searchWord.length > 0,
                        child: Container(
                            margin:
                                EdgeInsets.only(top: 30, left: 17, right: 17),
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
                                    productList = productsnapshot.data!.docs;
                                    int j = 0;
                                   
                                    for (int i = 0;i < productList.length;i++) {
                                      

                                     if (productList[i]['Name'].substring(0,searchWord.length).toLowerCase()==searchWord.toLowerCase()){
                                        newList.insert(j, productList[i]);
                                      }
                                    }
                                    return newList.length>0?GridView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: newList.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisExtent: 204,
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return SearchMedicineLayout(
                                            index: index,
                                          );
                                        }):Center(
                                          child: Text("No Result Found :_("),
                                        );
                                  }
                                })),
                      )
                    ],
                  ),
                ),
              ],
            )));
  }
}

//categories

class CategoriesList extends StatefulWidget {
  final bool isSelected;
  int index;
  Function changeCurrent;
  CategoriesList(
      {Key? key,
      required this.index,
      required this.isSelected,
      required this.changeCurrent})
      : super(key: key);
  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.changeCurrent(widget.index);
        newList.clear();
      },
      child: Container(
        margin: EdgeInsets.only(right: 5, left: 10),
        width: 135,
        decoration: BoxDecoration(
            gradient: widget.isSelected
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF82C6FB), Color(0XFF69BCFC)])
                : LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, Colors.white]),
            border: Border.all(
                color: widget.isSelected ? Colors.white : Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: 35,
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color:
                              widget.isSelected ? Colors.white : Colors.blue)),
                  child: Center(
                    child: new Image.asset(
                      categoriesList[widget.index].icon!,
                      height: 19,
                      width: 19,
                    ),
                  )),
              SizedBox(
                width: 3,
              ),
              Text(
                categoriesList[widget.index].name!,
                style: GoogleFonts.lato(
                    fontSize: 16,
                    color: widget.isSelected ? Colors.white : Colors.blue),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
