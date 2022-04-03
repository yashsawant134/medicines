import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicines/screens/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'OtpVerificationScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController number_controller = new TextEditingController();
  String phone = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                stops: [
                  0.1,
                  0.29,
                  0.6,
                  0.9,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0Xff69bcfc).withOpacity(0.5),
                  Colors.white,
                  Colors.white,
                  Colors.white,
                ],
              )),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Image.asset("assets/png/logo.png", height: 100, width: 100),
                    Text(
                      "Drug Store",
                      style: GoogleFonts.lato(
                          fontSize: 25,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Text(
                          "Welcome to Drug Store",
                          style: GoogleFonts.lato(
                              fontSize: 28,
                              color: Colors.black,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          "A six digit otp will be send",
                          style: GoogleFonts.lato(
                              fontSize: 19,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    TextFormField(
                      controller: number_controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.phone_android_outlined,
                          color: Colors.black,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: Colors.grey,
                        prefixText: "+91",
                        labelText: 'Phone Number',
                        //lable style
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    // InkWell(
                    //   onTap: () {
                    // setState(() {
                    //   phone = number_controller.text;
                    //   checkIfDocExists(phone, context);
                    // });
                    //   },
                    //   child: Container(
                    //     width: MediaQuery.of(context).size.width,
                    //     height: 60,
                    //     decoration: BoxDecoration(
                    //       boxShadow: [
                    //         BoxShadow(
                    //           blurRadius: 9,
                    //           color: Color(0Xff69bcfc).withOpacity(0.5),
                    //         ),
                    //       ],
                    //       borderRadius: BorderRadius.all(Radius.circular(20)),
                        //   gradient: LinearGradient(
                        //     begin: Alignment.topLeft,
                        //     end: Alignment.bottomRight,
                        //     colors: [Color(0xFF82C6FB), Color(0XFF69BCFC)],
                        //   ),
                        // ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           "Log In",
                            //   style: GoogleFonts.lato(
                            //       color: Colors.white,
                            //       fontSize: 21,
                            //       fontWeight: FontWeight.bold),
                            // )
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            phone = number_controller.text;
                            checkIfDocExists(phone, context);
                          });
                        },
                        child: Text("Log In",style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold),
                            ),
                        style: ElevatedButton.styleFrom(
                          primary:Color(0xFF82C6FB), 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 9.0,
                          
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't Have An Account?",
                          style: GoogleFonts.lato(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Registration()));
                          },
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.lato(
                                fontSize: 19,
                                color: Color(0Xff69bcfc),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91" + phone,
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {
          Fluttertoast.showToast(
            msg: e.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OtpVerificationScreen(
                        number_controller.text, verificationId)));
          }
          ;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {});
        },
        timeout: Duration(seconds: 60));
  }

  void checkIfDocExists(String docId, BuildContext context) async {
    try {
      // Get reference to Firestore collection
      var collectionRef = FirebaseFirestore.instance.collection('users');

      var doc = await collectionRef.doc(docId).get();
      if (doc.exists) {
        _verifyPhone();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('phone_number', docId);
      } else {
        Fluttertoast.showToast(
          msg: "This phone number is not registered",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0Xff69bcfc),
          textColor: Colors.white,
          fontSize: 16.0,
        );
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
}
