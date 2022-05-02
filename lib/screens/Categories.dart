import 'package:flutter/material.dart';
import 'package:medicines/models/category_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicines/screens/CategoryDetails.dart';


class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 20,),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: categoriesList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 58,
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 15),
                itemBuilder: (BuildContext context, int index) {
                  return 
                  InkWell(
                    onTap: (){
                     Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      CategoryDetailsDart(category: categoriesList[index].name!,)));
                    },
                    child: CategoryScreenLayout(
                      index: index,
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}

class CategoryScreenLayout extends StatelessWidget {
  int index;
   CategoryScreenLayout({required this.index});

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsets.only(right: 5, left: 10),
        width: 135,
        decoration: BoxDecoration(
           
            color: Color(0Xff69bcfc).withOpacity(0.08),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                      categoriesList[index].icon!,
                      height: 19,
                      width: 19,
                    ),
                 
              SizedBox(
                width: 3,
              ),
              Text(
                categoriesList[index].name!,
                style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.black),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      );
    
  }
}