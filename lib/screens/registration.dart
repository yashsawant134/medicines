import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children:[ 
              
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
            )
              ),
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
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          "Welcome Back!",
                          style: GoogleFonts.lato(
                              fontSize: 33,
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
                          "Please register to get started",
                          style: GoogleFonts.lato(
                              fontSize: 19,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.person_outline_rounded,
                          color: Colors.black,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: Colors.grey,
          
                        labelText: 'Enter Name',
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
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: Colors.grey,
          
                        labelText: 'abc@gmail.com',
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
                      height: 10,
                    ),
                    TextFormField(
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
                    Container(
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
                            "Register",
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 21,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 40,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(
                              "Have An Account?",
                              style: GoogleFonts.lato(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),

                            SizedBox(width: 5,),
                             Text(
                              "Sign In",
                              style: GoogleFonts.lato(
                                  fontSize: 19,
                                  color: Color(0Xff69bcfc),
                                  fontWeight: FontWeight.w600),
                            ),
                       ],
                     ),
                  ],
                ),
              ),
            ),]
          ),
        ));
  }
}
