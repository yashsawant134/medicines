import 'dart:io';

class SearchMedicine{
  String icon;
  String name;
  String company_name;
  String intake;
  
  SearchMedicine({required this.icon,required this.name,required this.company_name,required this.intake});
}

List<SearchMedicine> searchMedicineList=medicineData.map(
  (item) =>SearchMedicine(
    icon: item['icon']??"",
    name:item['name']??"",
    company_name: item['company_name']??"",
    intake: item['intake']??""
  )
  ).toList();

var medicineData=[
  {
    "icon":"assets/medicines/calbod.jpeg",
    "name":"Calbo-D",
    "company_name":"Square Ltd.",
    "intake" :"325mg"
  },{
    "icon":"assets/medicines/caltrex.jpg",
    "name":"Caltrex",
    "company_name":"Beximco Pharma",
    "intake" :"325mg"
  },
  {
    "icon":"assets/medicines/nutrileon_calcium.jpg",
    "name":"Calcium",
    "company_name":"Nutrileon",
    "intake" :"325mg"
  },
  {
    "icon":"assets/medicines/zymet.jpg",
    "name":"Zymet",
    "company_name":"Square Ltd.",
    "intake" :"325mg"
  },
 {
    "icon":"assets/medicines/calbod.jpeg",
    "name":"Calbo-D",
    "company_name":"Square Ltd.",
    "intake" :"325mg"
  },{
    "icon":"assets/medicines/caltrex.jpg",
    "name":"Caltrex",
    "company_name":"Beximco Pharma",
    "intake" :"325mg"
  },
  {
    "icon":"assets/medicines/nutrileon_calcium.jpg",
    "name":"Calcium",
    "company_name":"Nutrileon",
    "intake" :"325mg"
  },
  {
    "icon":"assets/medicines/zymet.jpg",
    "name":"Zymet",
    "company_name":"Square Ltd.",
    "intake" :"325mg"
  },
];