import 'dart:io';
class CategoryModel{
  String? icon;
  String? name;

  CategoryModel({required this.icon,required this.name});
}

List<CategoryModel> categoriesList= categoryData.map(
  (item) => CategoryModel(
    icon :item['icon'],
    name :item['name']
  ),).toList();

var categoryData=[
  {
    "icon":"assets/png/alopathy.png",
    "name":"Alopathy",
  },
  {
    "icon":"assets/png/ayurvedic.png",
    "name":"Ayurvedic",
  },
  {
    "icon":"assets/png/homeo.png",
    "name":"Homeo"
  },
  {
    "icon":"assets/png/cardio.png",
    "name":"Cardio"
  },
  {
    "icon":"assets/png/beautytreatment.png",
    "name":"Beauty"
  },
  {
    "icon":"assets/png/dentalcare.png",
    "name":"Dental"
  },
  {
    "icon":"assets/png/joints.png",
    "name":"Bones"
  },
  {
    "icon":"assets/png/stomach.png",
    "name":"Digestive"
  },{
    "icon":"assets/png/alopathy.png",
    "name":"Alopathy",
  },
  {
    "icon":"assets/png/ayurvedic.png",
    "name":"Ayurvedic",
  },
  {
    "icon":"assets/png/homeo.png",
    "name":"Homeo"
  },
  {
    "icon":"assets/png/cardio.png",
    "name":"Cardio"
  },
  {
    "icon":"assets/png/beautytreatment.png",
    "name":"Beauty"
  },
  {
    "icon":"assets/png/dentalcare.png",
    "name":"Dental"
  },
  {
    "icon":"assets/png/joints.png",
    "name":"Bones"
  },
  {
    "icon":"assets/png/stomach.png",
    "name":"Digestive"
  },{
    "icon":"assets/png/alopathy.png",
    "name":"Alopathy",
  },
  {
    "icon":"assets/png/ayurvedic.png",
    "name":"Ayurvedic",
  },
  {
    "icon":"assets/png/homeo.png",
    "name":"Homeo"
  },
  {
    "icon":"assets/png/cardio.png",
    "name":"Cardio"
  },
  {
    "icon":"assets/png/beautytreatment.png",
    "name":"Beauty"
  },
  {
    "icon":"assets/png/dentalcare.png",
    "name":"Dental"
  },
  {
    "icon":"assets/png/joints.png",
    "name":"Bones"
  },
  {
    "icon":"assets/png/stomach.png",
    "name":"Digestive"
  }
];