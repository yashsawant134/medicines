import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medicines/models/search_medicine.dart';
import 'package:medicines/screens/AddAddress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class AddToCart extends StatefulWidget {
  String? phoneNumber;
  AddToCart({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

num p_price = 0;
var checkoutList = [];
var productList = [];
var productImgL = [];
String? phone_no = "";
late Razorpay _razorpay;

 var options = {
    'key': 'rzp_test_zATQhierdFJPMP',
    'amount': 100,
    'name': 'Drug Store',
    'description': 'Medicines',
    'prefill': {'contact': phone_no, 'email': 'test@razorpay.com'}
  };
// SharedPreferences prefs = await SharedPreferences.getInstance();
//    String phone_number=  prefs.setString('phone_number', docId);
class _AddToCartState extends State<AddToCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black54,
          ),
        ),
        title: Container(
            child: Text(
          "Cart",
          style: GoogleFonts.lato(
            color: Colors.black,
          ),
        )),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Stack(children: [
            Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("users")
                                .doc(widget.phoneNumber)
                                .collection("cart")
                                .snapshots(),
                            builder: (context, productsnapshot) {
                              if (productsnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                productList = productsnapshot.data!.docs;

                                return productList.length > 0
                                    ? ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: productList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            margin: EdgeInsets.only(top: 15),
                                            child: Slidable(
                                              key: UniqueKey(),
                                              endActionPane: ActionPane(
                                                dismissible: DismissiblePane(
                                                    onDismissed: () {
                                                  setState(() {
                                                    String cart_pid =
                                                        productList[index]
                                                            ['product_id'];
                                                    productList.removeAt(index);
                                                    FirebaseFirestore.instance
                                                        .collection("users")
                                                        .doc(widget.phoneNumber)
                                                        .collection("cart")
                                                        .doc(cart_pid)
                                                        .delete();
                                                  });
                                                }),
                                                motion: ScrollMotion(),
                                                children: const [
                                                  // A SlidableAction can have an icon and/or a label.
                                                  SlidableAction(
                                                    onPressed: null,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    foregroundColor:
                                                        Colors.black,
                                                    icon: Icons.delete,
                                                    label: 'Delete',
                                                  ),
                                                ],
                                              ),
                                              startActionPane: ActionPane(
                                                key: UniqueKey(),
                                                // dismissible: DismissiblePane(onDismissed: () {}),
                                                dismissible: DismissiblePane(
                                                    onDismissed: () {
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
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    foregroundColor:
                                                        Colors.black,
                                                    icon: Icons.shopping_bag_rounded,
                                                    label: 'Add',
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
                                                          color: Color(
                                                                  0Xff69bcfc)
                                                              .withOpacity(0.2),
                                                          blurRadius: 6,
                                                        ),
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  19))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                              color: Color(
                                                                      0xFF82C6FB)
                                                                  .withOpacity(
                                                                      0.14),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20))),
                                                          child: Center(
                                                            child: new Image
                                                                .network(
                                                              productList[index]
                                                                  ['img'],
                                                              width: 70,
                                                              height: 70,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                productList[
                                                                        index]
                                                                    ['name'],
                                                                style: GoogleFonts.lato(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                height: 7,
                                                              ),
                                                              Text(
                                                                productList[index]['for']
                                                                            .length >
                                                                        24
                                                                    ? productList[index]['for'].substring(
                                                                            0,
                                                                            21) +
                                                                        "..."
                                                                    : productList[
                                                                            index]
                                                                        ['for'],
                                                                style: GoogleFonts.lato(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                height: 21,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  InkWell(
                                                                    onTap: (() {
                                                                       int q=productList[index]['qty']>=2?productList[index]['qty']-1:productList[index]['qty'];
                                                                      FirebaseFirestore.instance.collection("users").doc(widget.phoneNumber).collection("cart").doc(productList[index].id).update({'qty':q});
                                                                    }),
                                                                    child: Container(
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
                                                                              color: Color(0Xff69bcfc).withOpacity(
                                                                                  0.5),
                                                                              blurRadius:
                                                                                  9,
                                                                              spreadRadius:
                                                                                  2),
                                                                        ],
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            new Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color: Colors
                                                                              .white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 12,
                                                                  ),
                                                                  Text(
                                                                    productList[index]
                                                                            [
                                                                            'qty']
                                                                        .toString(),
                                                                    style: GoogleFonts.lato(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 12,
                                                                  ),
                                                                  InkWell(
                                                                    onTap: (){
                                                                      int q=productList[index]['qty']<10?productList[index]['qty']+1:productList[index]['qty'];
                                                                      FirebaseFirestore.instance.collection("users").doc(widget.phoneNumber).collection("cart").doc(productList[index].id).update({'qty':q});
                                                                    },
                                                                    child: Container(
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
                                                                              color: Color(0Xff69bcfc).withOpacity(
                                                                                  0.5),
                                                                              blurRadius:
                                                                                  9,
                                                                              spreadRadius:
                                                                                  2),
                                                                        ],
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            new Icon(
                                                                          Icons
                                                                              .add,
                                                                          color: Colors
                                                                              .white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 16,
                                                                  ),
                                                                  Text(
                                                                    (productList[index]['qty'] *
                                                                            productList[index]['price'])
                                                                        .toString(),
                                                                    style: GoogleFonts.lato(
                                                                        color: Color(
                                                                            0xFF82C6FB),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            16),
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
                                        })
                                    : Center(
                                        child: Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            color: Colors.white,
                                            child: Image.network(
                                              "https://media.istockphoto.com/vectors/empty-shopping-bag-icon-online-business-vector-icon-template-vector-id861576608?k=20&m=861576608&s=612x612&w=0&h=UgHaPYlYrsPTO6BKKTzizGQqFgqEnn7eYK9EOA16uDs=",
                                            )),
                                      );
                              }
                            })),
                  ],
                )),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.transparent,
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
          ])),
      bottomNavigationBar: InkWell(
        onTap: () {
          if (checkoutList.length > 0) bottomPaymentSheet();
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
                "Checkout",
                style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getPhonenum();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

 
//Waf5ymDyF6CqpEltwkSa2ycw
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    FirebaseFirestore.instance
        .collection("users")
        .doc(phone_no)
        .collection("history")
        .doc()
        .set({
      'date': "",
      'orderid': response.paymentId,
      'status': true,
      'totalPayment': (p_price - 0.2 * p_price).toString()
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    // Fluttertoast.showToast(
    //   msg: response.toString(),
    //   toastLength: Toast.LENGTH_LONG,
    //   gravity: ToastGravity.CENTER,
    //   timeInSecForIosWeb: 1,
    //   backgroundColor: Color(0Xff69bcfc),
    //   textColor: Colors.white,
    //   fontSize: 16.0,
    // );
    FirebaseFirestore.instance
        .collection("users")
        .doc(phone_no)
        .collection("history")
        .doc()
        .set({
      'date': "",
      'orderid': "xxxxxxxx",
      'status': false,
      'totalPayment': (p_price - 0.2 * p_price).toString()
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void bottomPaymentSheet() {
    p_price = 0;
    for (int i = 0; i < checkoutList.length; i++) {
      p_price = p_price + (checkoutList[i]['price'] * checkoutList[i]['qty']);
    }
    showAdaptiveActionSheet(
      context: context,
      title: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          const Text(
            "Total Bill",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      androidBorderRadius: 30,
      bottomSheetColor: Colors.white,
      actions: [
        BottomSheetAction(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Product Price ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 143, 142, 142),
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Rs " + p_price.toString(),
                        style: TextStyle(
                            color: Color.fromARGB(255, 21, 21, 21),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Discount Offer ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 143, 142, 142),
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "- 20%",
                        style: TextStyle(
                            color: Color.fromARGB(255, 21, 21, 21),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  color: Colors.teal.shade100,
                  thickness: 1.0,
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Grand Total :",
                        style: TextStyle(
                            color: Color.fromARGB(255, 21, 21, 21),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Rs " + (p_price - 0.2 * p_price).toString(),
                        style: TextStyle(
                            color: Color.fromARGB(255, 21, 21, 21),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                InkWell(
                  onTap: () {
                        checkAddresIsAlreadyAdded(context);

                   
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 9,
                          color: Color(0Xff69bcfc).withOpacity(0.5),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(15)),
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
                          "Proceed to Payment",
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
            onPressed: () {}),
      ],
    );
  }
}

void checkAddresIsAlreadyAdded(BuildContext context) async {
  var collection = FirebaseFirestore.instance.collection('users');
  var docSnapshot = await collection.doc(phone_no).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
       if(data['postalcode'].toString().length>0){
          _razorpay.open(options);
       }else{
         Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AddAddress()));
       } // <-- The value you want to retrieve.
    // Call setState if needed.
  }
}

void getPhonenum() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  phone_no = prefs.getString('phone_number');
}

void addCheckOutItem(int index) {
  if (!productImgL.contains(productList[index]['img'])) {
    checkoutList.add(productList[index]);
    productImgL.add(productList[index]['img']);
  }
}

// getPhonenumber() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   phone_number = prefs.getString('phone_number');

//   return phone_number;
// }

// void getCartProductId() async {
//   String phone_number = await getPhonenumber();
//   var collectionRef = await FirebaseFirestore.instance
//       .collection('users')
//       .doc(phone_number)
//       .collection("cart");
//   QuerySnapshot querySnapshot = await collectionRef.get();

//   productList = querySnapshot.docs.map((doc) => doc.id).toList();
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
        color: Colors.transparent,
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
              child: new Image.network(
                checkoutList[widget.index]['img'],
                width: 70,
                height: 70,
              )),
        ),
      ),
    );
  }
}
