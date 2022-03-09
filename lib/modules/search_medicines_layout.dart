import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicines/models/search_medicine.dart';
import 'package:medicines/screens/home.dart';
import 'package:medicines/screens/product_details.dart';

class SearchMedicineLayout extends StatefulWidget {
  int index;

  SearchMedicineLayout({Key? key, required this.index}) : super(key: key);

  @override
  State<SearchMedicineLayout> createState() => _SearchMedicineLayoutState();
}

class _SearchMedicineLayoutState extends State<SearchMedicineLayout> {
  @override
  Widget build(BuildContext context) {
    String image = newList[widget.index]['img'];
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                    index: widget.index,
                    pid: newList[widget.index].id.toString(),
                  )),
        );
        
      },
      child: Container(
        // width: MediaQuery.of(context).size.width/2.5,
        height: 160,
        decoration: BoxDecoration(
            color: Color(0xFF82C6FB).withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(15))),

        child: Padding(
          padding: const EdgeInsets.only(top: 7, left: 8, right: 8, bottom: 2),
          child: Column(
            children: [
              Container(
                width: 135,
                height: 85,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Center(
                    child: Hero(
                  tag: "detailImage" + widget.index.toString(),
                  child: new Image.network(
                    image,
                    height: 70,
                    width: 85,
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          newList[widget.index]['name'],
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w400, fontSize: 19),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "(" + searchMedicineList[widget.index].intake + ")",
                          style: GoogleFonts.lato(
                              fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          newList[widget.index]['for'],
                          style: GoogleFonts.lato(
                              color: Colors.grey[600], fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Text(
                          newList[widget.index]['medicine_is'],
                          style:
                              GoogleFonts.lato(color: Colors.deepOrange[400]),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Text(
                          newList[widget.index]['company_name'],
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF82C6FB),
                            fontSize: 18,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
