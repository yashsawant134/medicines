import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicines/bottom_nav/bottom_nav_bar.dart';
import 'package:medicines/screens/home.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phone,verificationId;
  const OtpVerificationScreen(this.phone,this.verificationId);

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String verificationOtp = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Verify Account",
                    style: GoogleFonts.lato(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Text(
                    "We just sent you a verification code\nto +91 " +
                        widget.phone,
                    style: GoogleFonts.lato(
                        fontSize: 17,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              PinCodeTextField(
                keyboardType: TextInputType.number,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                    inactiveColor: Color(0Xff69bcfc)),
                onCompleted: (v) {
                  print("Completed");
                },
                onChanged: (value) {
                  setState(() {
                    verificationOtp=value;
                  });
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  return true;
                },
                appContext: context,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Resend Otp",
                    style: GoogleFonts.lato(
                        fontSize: 19,
                        color: Color(0Xff69bcfc),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  verifyOTP();
                },
                child: Container(
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
                        "Verify Account",
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

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: verificationOtp);

    await FirebaseAuth.instance.signInWithCredential(credential).then(
      (value) {
        print("You are logged in successfully");
        Fluttertoast.showToast(
          msg: "You are logged in successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
    ).whenComplete(
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavBar(),
          ),
        );
      },
    );
  }
}
