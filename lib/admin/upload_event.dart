import 'dart:math';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:random_string/random_string.dart';
import '../services/database.dart';



class UploadEvent extends StatefulWidget {
  const UploadEvent({super.key});

  @override
  State<UploadEvent> createState() => _UploadEventState();
}

class _UploadEventState extends State<UploadEvent> {
  TextEditingController namecontroller= new TextEditingController();
  TextEditingController pricecontroller= new TextEditingController();
  TextEditingController locationcontroller= new TextEditingController();
  TextEditingController detailcontroller= new TextEditingController();

  final List<String> eventcategory=["Music","Food","Clothing","Festival"];
  String? value;
  final ImagePicker _picker =ImagePicker();
  File? selectedImage;

  Future getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    } else {
      print('No image selected.');
    }
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime=TimeOfDay(hour: 10, minute: 00);

  Future<void> _pickDate() async{
    final DateTime? pickDate =await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100), // or any future year you want to allow
    );

        if (pickDate != null && pickDate != selectedDate){
      setState(() {
        selectedDate = pickDate;
      });
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('hh:mm a').format(dt);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFCE4EC),
              Color(0xFFFCE4EC),
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),


        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
             child: Icon(Icons.arrow_back_ios_new_outlined)),
            SizedBox(width:MediaQuery.of(context).size.width/4.0,),
            Text(
                "Upload Event",
               style: TextStyle(color: Colors.pink.shade400, fontSize: 25.0, fontWeight:FontWeight.bold ),
            )
          ],),
          SizedBox(height: 5.0,),
          selectedImage!= null?
    Center(
    child:
    ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child:
    Image.file(
    selectedImage!, height:150, width: 150,fit: BoxFit.cover,))):
          Center(
            child: GestureDetector(
            onTap: (){
              getImage();
    },
          child: Container(
            height: 140,
            width: 140,
            decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2.0), borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.camera_alt_outlined),
          ),
    ),
          ),

          Text(
            "Enter Event Name",
            style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight:FontWeight.bold
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: namecontroller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter Event Name"

              ),
            ),
          ),
          SizedBox(height: 5.0,),
          Text(
            "Ticket Price",
            style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight:FontWeight.bold
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: pricecontroller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Price"

              ),
            ),
          ),
          SizedBox(height: 5.0,),

          Text(
            "Event Location",
            style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight:FontWeight.bold
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: locationcontroller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Location"

              ),
            ),
          ),
          Text(
            "Select Category",
            style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight:FontWeight.bold
            ),
          ),


          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButtonHideUnderline(
            child: DropdownButton<String>
              (
                items: eventcategory.map((item) => DropdownMenuItem(value:item, child:Text(item,style: TextStyle(fontSize: 18.0,color: Colors.black),
                ) )).toList(),
                onChanged: ((value) => setState(() {
                  this.value=value;

                })),
             dropdownColor: Colors.white,
              hint: Text("Select Category"),
                iconSize: 36 ,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
              value: value,
          ),
          ),
          ),

          Row(children: [
            GestureDetector(
              onTap: (){
                _pickDate();
              },
            child: Icon(
            Icons.calendar_month_rounded,
             color: Colors.pink.shade600,
             size: 20.0,  ),
            ),
            SizedBox(width: 10.0,),
            Text(
              DateFormat("yyyy-MM-dd").format(selectedDate),
              style: TextStyle(
                color: Colors.black,
                fontSize: 13.0,
                fontWeight: FontWeight.bold,

              ),
            ),

            SizedBox(width: 150.0,),
            GestureDetector(
              onTap: (){
                _pickTime();
              },

              child:
            Icon(Icons.alarm, color: Colors.pink.shade600, size:20.0,),),
            SizedBox(width: 10.0,),
            Text(
              formatTimeOfDay(selectedTime),
              style: TextStyle(
                color: Colors.black,
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              ),
            )

          ],),


          Text(
            "Event Details",
            style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight:FontWeight.bold
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: detailcontroller,
              maxLines: 6,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Describe about your event....."

              ),
            ),
          ),
          SizedBox(height: 5.0,),
          GestureDetector(
            onTap: () async {
             // String addId = randomAlphaNumeric(10);
              //Reference firebaseStorageRef = FirebaseStorage.instance.ref().child("blogImage").child(addId);

              //final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

              //TaskSnapshot snapshot = await task;

              //String downloadUrl = await snapshot.ref.getDownloadURL();
              String id = randomAlphaNumeric(10);
              String firstletter = namecontroller.text.substring(0, 1).toUpperCase();

              Map<String, dynamic> uploadevent = {
                "Image": "",
                "Name": namecontroller.text,
                "Price": pricecontroller.text,
                "Category": value,
                "SearchKey": firstletter,
                "Location": locationcontroller.text,
                "Detail": detailcontroller.text,
                "UpdatedName": namecontroller.text.toUpperCase(),
                "Date": DateFormat("yyyy-MM-dd").format(selectedDate),
                "Time": formatTimeOfDay(selectedTime),
              };


              await DatabaseMethods().addEvent(uploadevent, id).then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(
                      "Event Uploaded Successfully",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                );
                setState(() {
                  namecontroller.text="";
                  pricecontroller.text="";
                  detailcontroller.text="";
                  selectedImage=null;
                });
              });
            },

            child:
          Center(
          child:
          Container(
            height: 35,
            decoration: BoxDecoration(
              color: Colors.pink.shade600,
              borderRadius: BorderRadius.circular(20)
            ),
            width:200,
            child: Center(
            child: Text(
              "Upload",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight:FontWeight.bold
              ),
            ),
          ),
          ),
          ),
          ),
        ],
      ),
    ),
    );
  }
}
