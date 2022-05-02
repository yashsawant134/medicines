import 'package:sqflite/sqflite.dart';

import '../database/DatabaseHelper.dart';

class MyMedicineModel {
  String? med_name,time,medImgUrl;
  int? minutes,dose;
 
  MyMedicineModel( this.med_name, this.dose,this.medImgUrl,this.minutes,this.time);
 
  MyMedicineModel.fromMap(Map<String, dynamic> map) {
    med_name = map['med_name'];
    dose=map['dose'];
    medImgUrl=map['medImgUrl'];
    minutes=map['minutes'];
    time = map['time']; 
  }
 
  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnName: med_name,
      DatabaseHelper.columnDose:dose,
      DatabaseHelper.medImgUrl:medImgUrl,
      DatabaseHelper.time:time,
      DatabaseHelper.minute:minutes,
      
    };
  }
}