import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medicines/models/search_medicine.dart';

class AddToCart extends StatefulWidget {
  AddToCart({Key? key}) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

List<SearchMedicine> checkoutList = [];

class _AddToCartState extends State<AddToCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
            padding: const EdgeInsets.only(left: 0, top: 15),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.black,
                ))),
        title: Container(
            margin: EdgeInsets.only(top: 15),
            child: Text(
              "Cart",
              style: GoogleFonts.lato(
                color: Colors.black,
              ),
            )),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: medicineData.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: Slidable(
                                    key: UniqueKey(),
                                    endActionPane: ActionPane(
                                      dismissible:
                                          DismissiblePane(onDismissed: () {
                                        setState(() {
                                          medicineData.removeAt(index);
                                        });
                                      }),
                                      motion: ScrollMotion(),
                                      children: const [
                                        // A SlidableAction can have an icon and/or a label.
                                        SlidableAction(
                                          onPressed: null,
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.black,
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        ),
                                      ],
                                    ),
                                    startActionPane: ActionPane(
                                      key: UniqueKey(),
                                      // dismissible: DismissiblePane(onDismissed: () {}),
                                      dismissible:
                                          DismissiblePane(onDismissed: () {
                                        setState(() {
                                          addCheckOutItem(index);
                                          
                                        });
                                      }),
                                      motion: BehindMotion(),
                                      children: [
                                        SlidableAction(
                                          // An action can be bigger than the others.

                                          flex: 2,
                                          onPressed: null,
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.black,
                                          icon: Icons.archive,
                                          label: 'Archive',
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: MediaQuery.of(context)
                                                .size
                                                .width /
                                            1.05,
                                        height: 145,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0Xff69bcfc)
                                                    .withOpacity(0.2),
                                                blurRadius: 6,
                                              ),
                                            ],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25))),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12,
                                              right: 0,
                                              top: 5,
                                              bottom: 8),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 130,
                                                height: 130,
                                                decoration: BoxDecoration(
                                                    color: Color(0xFF82C6FB)
                                                        .withOpacity(0.14),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                child: Center(
                                                  child: new Image.asset(
                                                    searchMedicineList[index]
                                                        .icon,
                                                    width: 70,
                                                    height: 70,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                    16.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Text(
                                                      searchMedicineList[
                                                              index]
                                                          .name,
                                                      style: GoogleFonts.lato(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                    ),
                                                    SizedBox(
                                                      height: 7,
                                                    ),
                                                    Text(
                                                      "Xylometazoline",
                                                      style: GoogleFonts.lato(
                                                          fontSize: 15,
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                    ),
                                                    SizedBox(
                                                      height: 21,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 30,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFF82C6FB),
                                                            shape: BoxShape
                                                                .circle,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Color(
                                                                          0Xff69bcfc)
                                                                      .withOpacity(
                                                                          0.5),
                                                                  blurRadius:
                                                                      9,
                                                                  spreadRadius:
                                                                      2),
                                                            ],
                                                          ),
                                                          child: Center(
                                                            child: new Icon(
                                                              Icons.remove,
                                                              color: Colors
                                                                  .white,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 12,
                                                        ),
                                                        Text(
                                                          "02",
                                                          style: GoogleFonts.lato(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          width: 12,
                                                        ),
                                                        Container(
                                                          width: 30,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFF82C6FB),
                                                            shape: BoxShape
                                                                .circle,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Color(
                                                                          0Xff69bcfc)
                                                                      .withOpacity(
                                                                          0.5),
                                                                  blurRadius:
                                                                      9,
                                                                  spreadRadius:
                                                                      2),
                                                            ],
                                                          ),
                                                          child: Center(
                                                            child: new Icon(
                                                              Icons.add,
                                                              color: Colors
                                                                  .white,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 16,
                                                        ),
                                                        Text(
                                                          "\$ 48.00 ",
                                                          style: GoogleFonts.lato(
                                                              color: Color(
                                                                  0xFF82C6FB),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
                                                        )
                                                      ],
                                                    )
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
                              }),
                        )
                      ])),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 130,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: checkoutList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return checkoutBottomItem(
                          index,
                        );
                      }),
                ),
              )
            ],
          )),
      bottomNavigationBar: Container(
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
              "Checkout",
              style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

void addCheckOutItem(int index) {
  checkoutList.add(searchMedicineList.elementAt(index));
}

// class CartItem extends StatefulWidget {
//   int index;
//   CartItem({required this.index});
//   @override
//   State<CartItem> createState() => _CartItemState();
// }

// class _CartItemState extends State<CartItem> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => Tp()),
//         );
//       },
//       child: Container(
//         margin: EdgeInsets.only(top: 15),
//         child: Slidable(
//           key: UniqueKey(),
//           endActionPane: ActionPane(
//             dismissible: DismissiblePane(onDismissed: () {
//               setState(() {
//                 medicineData.removeAt(widget.index);
//               });
//             }),
//             motion: ScrollMotion(),
//             children: const [
//               // A SlidableAction can have an icon and/or a label.
//               SlidableAction(
//                 onPressed: null,
//                 backgroundColor: Colors.transparent,
//                 foregroundColor: Colors.black,
//                 icon: Icons.delete,
//                 label: 'Delete',
//               ),
//             ],
//           ),
//           startActionPane: ActionPane(
//             key: UniqueKey(),
//             // dismissible: DismissiblePane(onDismissed: () {}),
//             dismissible: DismissiblePane(onDismissed: () {
//               setState(() {
//                 addCheckOutItem(widget.index);
//                 Fluttertoast.showToast(
//                   msg: checkoutList.length.toString(),
//                   toastLength: Toast.LENGTH_SHORT,
//                   gravity: ToastGravity.CENTER,
//                   timeInSecForIosWeb: 1,
//                   backgroundColor: Colors.red,
//                   textColor: Colors.white,
//                   fontSize: 16.0,
//                 );
//               });
//             }),
//             motion: BehindMotion(),
//             children: [
//               SlidableAction(
//                 // An action can be bigger than the others.

//                 flex: 2,
//                 onPressed: null,
//                 backgroundColor: Colors.transparent,
//                 foregroundColor: Colors.black,
//                 icon: Icons.archive,
//                 label: 'Archive',
//               ),
//             ],
//           ),
//           child: Center(
//             child: Container(
//               width: MediaQuery.of(context).size.width / 1.05,
//               height: 145,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color(0Xff69bcfc).withOpacity(0.2),
//                       blurRadius: 6,
//                     ),
//                   ],
//                   borderRadius: BorderRadius.all(Radius.circular(25))),
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                     left: 12, right: 0, top: 5, bottom: 8),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 130,
//                       height: 130,
//                       decoration: BoxDecoration(
//                           color: Color(0xFF82C6FB).withOpacity(0.14),
//                           borderRadius: BorderRadius.all(Radius.circular(20))),
//                       child: Center(
//                         child: new Image.asset(
//                           searchMedicineList[widget.index].icon,
//                           width: 70,
//                           height: 70,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             searchMedicineList[widget.index].name,
//                             style: GoogleFonts.lato(
//                                 fontSize: 20,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(
//                             height: 7,
//                           ),
//                           Text(
//                             "Xylometazoline",
//                             style: GoogleFonts.lato(
//                                 fontSize: 15,
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(
//                             height: 21,
//                           ),
//                           Row(
//                             children: [
//                               Container(
//                                 width: 30,
//                                 height: 30,
//                                 decoration: BoxDecoration(
//                                   color: Color(0xFF82C6FB),
//                                   shape: BoxShape.circle,
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color:
//                                             Color(0Xff69bcfc).withOpacity(0.5),
//                                         blurRadius: 9,
//                                         spreadRadius: 2),
//                                   ],
//                                 ),
//                                 child: Center(
//                                   child: new Icon(
//                                     Icons.remove,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 12,
//                               ),
//                               Text(
//                                 "02",
//                                 style: GoogleFonts.lato(
//                                     fontSize: 16,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               SizedBox(
//                                 width: 12,
//                               ),
//                               Container(
//                                 width: 30,
//                                 height: 30,
//                                 decoration: BoxDecoration(
//                                   color: Color(0xFF82C6FB),
//                                   shape: BoxShape.circle,
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color:
//                                             Color(0Xff69bcfc).withOpacity(0.5),
//                                         blurRadius: 9,
//                                         spreadRadius: 2),
//                                   ],
//                                 ),
//                                 child: Center(
//                                   child: new Icon(
//                                     Icons.add,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 16,
//                               ),
//                               Text(
//                                 "\$ 48.00 ",
//                                 style: GoogleFonts.lato(
//                                     color: Color(0xFF82C6FB),
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class checkoutBottomItem extends StatefulWidget {
  final int index;
  checkoutBottomItem(this.index);

  @override
  State<checkoutBottomItem> createState() => _checkoutBottomItemState();
}

class _checkoutBottomItemState extends State<checkoutBottomItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8),
      width: 100,
      height: 100,
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0Xff69bcfc).withOpacity(0.5),
           
          )
        ],
        shape: BoxShape.circle,
      ),
      child: Container(
        child: Center(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(35.0),
              child: new Image.asset(
                checkoutList[widget.index].icon,
                width: 70,
                height: 70,
              )),
        ),
      ),
    );
  }
}
