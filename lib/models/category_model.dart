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
  }
];