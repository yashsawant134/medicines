import 'package:flutter/material.dart';
import 'package:medicines/screens/cart.dart';
import 'package:medicines/screens/home.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0;

  final ScreenPages = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
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
                                builder: (context) => AddToCart()),
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
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 15),
          child: Image.asset(
            "assets/png/sidebar_menu.png",
            width: 28,
            height: 28,
          ),
        ),
      ),
      body: ScreenPages[pageIndex],

      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              icon: pageIndex == 0
                  ? new Image.asset("assets/png/homepage_fill.png",color: Color(0Xff69bcfc),)
                  : new Image.asset("assets/png/homepage.png"),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: pageIndex == 1
                  ? new Image.asset("assets/png/menu_fill.png")
                  : new Image.asset("assets/png/menu.png"),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: pageIndex == 2
                  ? new Image.asset("assets/png/heart_fill.png")
                  : new Image.asset("assets/png/heart.png"),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              icon: pageIndex == 3
                  ? const Icon(
                      Icons.person,
                      color: Color(0Xff69bcfc),
                      size: 35,
                    )
                  : const Icon(
                      Icons.person_outline,
                      size: 35,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
