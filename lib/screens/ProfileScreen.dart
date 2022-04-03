import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicines/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  radius: 68,
                  child: ClipOval(
                    child: Image.network(
                      "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                      width: 135,
                      height: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Column(
                    children: [
                      Text(
                        "Rohit",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 90,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Color(0xFFEFEEFA),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/png/editprofile.png",
                                          color: Color(0xFF867CFD),
                                          width: 34,
                                          height: 34,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      "Edit Profile",
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 21,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(Icons.arrow_forward_ios_rounded),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 90,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Color(0xFFFAECF3),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/png/medicinecapsuel.png",
                                          color: Color(0xFFFC99CA),
                                          width: 34,
                                          height: 34,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      "My Medicines",
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 21,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(Icons.arrow_forward_ios_rounded),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 90,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Color(0xFFFAECEC),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/png/history.png",
                                          color: Color(0xFFFB4C4C),
                                          width: 34,
                                          height: 34,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      "Order History",
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 21,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(Icons.arrow_forward_ios_rounded),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 90,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Color(0xFFF3ECFA),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/png/address.png",
                                          color: Color(0xFFCDA6F3),
                                          width: 34,
                                          height: 34,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      "Address",
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 21,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(Icons.arrow_forward_ios_rounded),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showCustomDialog(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 90,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Color(0xFFEFEEFA),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            "assets/png/logout.png",
                                            color: Color(0xFF7366FE),
                                            width: 34,
                                            height: 34,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        "Logout",
                                        style: GoogleFonts.lato(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 21,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.arrow_forward_ios_rounded),
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void showCustomDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          height: 240,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(40)),
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.power_settings_new_rounded,size: 70,color: Colors.red[300],),
                SizedBox(height: 20,),
                
                 DefaultTextStyle(
                    style: TextStyle(
                       fontWeight: FontWeight.w500,
                       fontSize: 20,
                       color: Colors.black.withOpacity(0.8)
                     ),
                   child: Text(
                     "Are you sure you want to logout",
                    
                   ),
                 ),
                SizedBox(height: 20,),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          FirebaseAuth.instance.signOut();
                           removeSharedpreference();
                           Navigator.of(context).popUntil((route) => route.isFirst);
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
                        },
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width / 2.18,
                          decoration: BoxDecoration(
                              color: Color(0xFF82C6FB),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                              )),
                          child: Center(
                            child: DefaultTextStyle(
                               style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                  color: Colors.white
                                ),
                              child: Text(
                                "Yes",
                               
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width / 2.28,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 195, 195, 195),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(40),
                              )),
                              child: Center(
                            child: DefaultTextStyle(
                               style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                  color: Colors.black.withOpacity(0.5)
                                ),
                              child: Text(
                                "No",
                               
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}


removeSharedpreference() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("phone_number");
}
