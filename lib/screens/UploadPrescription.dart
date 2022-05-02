import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicines/bottom_nav/bottom_nav_bar.dart';
import 'package:medicines/models/search_medicine.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:medicines/modules/MyMedicineModel.dart';
import 'package:medicines/screens/AddScreens.dart';
import 'package:medicines/screens/SearcResultScreen.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
class UploadPrescription extends StatefulWidget {
  UploadPrescription({Key? key}) : super(key: key);

  @override
  State<UploadPrescription> createState() => _UploadPrescriptionState();
}
XFile? imageFile;
bool textScanning=false;
String scannedText="";
class _UploadPrescriptionState extends State<UploadPrescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Upload Prescription",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: (){
                      getImage();
                    },
                    child: DottedBorder(
                      dashPattern: [9, 5], 
                      borderType: BorderType.RRect,
                      color: Colors.grey,
                      radius: Radius.circular(12),
                      strokeCap: StrokeCap.round,
                      padding: EdgeInsets.all(16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child:imageFile==null && !textScanning? Container(
                          height: 450,
                          width: MediaQuery.of(context).size.width,
                          color: Color(0xFFF9FAFD),
                          child: Center(
                            child: Image.asset("assets/png/imagegallery.png",color: Color(0xFFC4C4C4),),
                          ),
                        ):Image.file(File(imageFile!.path)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text(
                        "Note : Always upload a clear version of\nyour prescription for getting better result",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.black),
                      )
                    ],
                  ),
              SizedBox(height: 20,),
                  Row(
                    children: [
                      Text(
                        scannedText,style: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.black),
                      )
                    ],
                  ),
                ],
              ),
                  Positioned(
                    bottom: 0,
                    left:0,
                    right: 0,
                    child: InkWell(
                      onTap: (){
                       if(scannedText.length>0) Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SearchResultScreen(searchword: scannedText,)));
                      },
                      child: Container(
                                      margin: EdgeInsets.only(left: 0, right: 0, bottom: 0),
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
                          "Done",
                          style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                                      ),
                                    ),
                    ),)
            ],
          ),
        ),
      ),
    );
  }

  void getRecognizedText(XFile image) async{

      final GoogleVisionImage visionImage =
                  GoogleVisionImage.fromFile(File(image.path));
      final TextRecognizer textRecognizer =
                  GoogleVision.instance.textRecognizer();

      final VisionText recognizedText =
                  await textRecognizer.processImage(visionImage);
      scannedText=recognizedText.text!;
    
      textScanning=false;
      setState(() {
        
      });
  }

  void getImage() async{
    try{
final pickedimage= await ImagePicker().pickImage(source: ImageSource.gallery);
      if(pickedimage!=null){
        imageFile=pickedimage;
        textScanning=true;
        setState(() {
          
        });
        getRecognizedText(pickedimage);
      }
    }catch (e){
      
        imageFile=null;
        textScanning=false;
        setState(() {
          
        });
      
    }
  }
}
