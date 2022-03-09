import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicines/screens/home.dart';
import 'package:medicines/screens/login.dart';
import 'package:medicines/screens/product_details.dart';
import 'package:medicines/screens/registration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bottom_nav/bottom_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.black,
        primarySwatch: Colors.blue,
      ),
      // home: BottomNavBar(),

      home:StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return BottomNavBar();
          }else{
            return LoginScreen();
          }
        },
      )


    );
  }
  
}
