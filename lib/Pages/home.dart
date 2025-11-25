import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkedinproject/Pages/detail_page.dart';
import 'package:linkedinproject/services/database.dart';
import 'package:intl/intl.dart';

import 'categories.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _HomeState();
}

class _HomeState extends State<home> {
  Stream? eventStream;

  ontheload()async{
    eventStream= await DatabaseMethods().getAllEvents();
    setState(() {

    });
  }
  @override
  void initState(){
    ontheload();
    super.initState();
  }

  Widget allEvents() {
    return StreamBuilder(
      stream: eventStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            Map<String, dynamic> data = ds.data() as Map<String, dynamic>;

            String inputDate = ds["Date"];
            DateTime parseDate = DateTime.parse(inputDate);
            String formattedDate = DateFormat("MM-dd").format(parseDate);
            DateTime currentDate = DateTime.now();
            bool hasPassed = currentDate.isAfter(parseDate);
            final String name = data["Name"] ?? "Unnamed Event";
            final String price = data["Price"] ?? "0";
            final String location = data["Location"] ?? "Unknown";

            return hasPassed?Container():
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(
                  date: ds["Date"],
                  detail: ds["Detail"],
                  image: ds["Image"] ,
                  location: ds["Location"],
                  name: ds["Name"],
                  price: ds["Price"],)));
              },
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "images/img_4.png",
                            height: 200,
                            width: 610,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.0, top: 10.0),
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              formattedDate,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      "Rs $price",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined),
                      Text(
                        location,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
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
        child: SingleChildScrollView( // ✅ Wrap the Column
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on_outlined),
                  SizedBox(width: 8.0),
                  Text(
                    "Boralesgamuwa",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35.0),
              Text(
                "Hello Vithurshana",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "There are 20 events around your location",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.0),

              SizedBox(height: 20.0),
              Container(
                height: 90,
                child: (

                    ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Categories(eventcategory: "Music")));
                          },
                          child:  Container(
                            margin: EdgeInsets.only(bottom: 5.0),

                            child:
                            Material(
                                elevation:3.0,
                                borderRadius: BorderRadius.circular(10),

                                child: Container(
                                  width:78,
                                  padding:EdgeInsets.all(10),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "images/img.png",
                                        height: 30,
                                        width: 30,
                                        fit: BoxFit.cover,),
                                      Text("Music", style: TextStyle(color: Colors.black, fontSize: 15.0),)
                                    ],
                                  ),
                                )
                            ),
                          ),
                        ),
                        SizedBox(width: 23.0,),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Categories(eventcategory: "Clothing")));
                          },
                          child:    Container(
                            margin: EdgeInsets.only(bottom: 5.0),

                            child:


                            Material(
                                elevation:3.0,
                                borderRadius: BorderRadius.circular(10),

                                child: Container(
                                  width:78,
                                  padding:EdgeInsets.all(10),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "images/img_1.png",
                                        height: 30,
                                        width: 30,
                                        fit: BoxFit.cover,),
                                      Text("Clothing", style: TextStyle(color: Colors.black, fontSize: 15.0),)
                                    ],
                                  ),
                                )
                            ),
                          ),
                        ),
                        SizedBox(width: 23.0,),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Categories(eventcategory: "Festival")));
                          },
                          child:

                          Container(
                            margin: EdgeInsets.only(bottom: 5.0),
                            child:
                            Material(
                                elevation:3.0,
                                borderRadius: BorderRadius.circular(10),

                                child: Container(
                                  width:75,
                                  padding:EdgeInsets.all(10),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "images/img_2.png",
                                        height: 30,
                                        width: 30,
                                        fit: BoxFit.cover,),
                                      Text("Festival", style: TextStyle(color: Colors.black, fontSize: 15.0),)
                                    ],
                                  ),
                                )
                            ),
                          ),
                        ),
                        SizedBox(width: 23.0,),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Categories(eventcategory: "Food")));
                          },
                          child:
                          Container(
                            margin: EdgeInsets.only(bottom: 5.0),
                            child:
                            Material(
                                elevation:3.0,
                                borderRadius: BorderRadius.circular(10),

                                child: Container(
                                  width:78,
                                  padding:EdgeInsets.all(10),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "images/img_3.png",
                                        height: 30,
                                        width: 30,
                                        fit: BoxFit.cover,),
                                      Text("Food", style: TextStyle(color: Colors.black, fontSize: 15.0),)
                                    ],
                                  ),
                                )
                            ),
                          ),
                        ),
                      ],
                    )
                ),


              ),
              SizedBox(height: 28.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text("Upcoming Events" , style:TextStyle(color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.bold ) ,),
                  Padding(padding: const EdgeInsets.only(right: 20.0)),
                  Text("See all" , style:TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w500 ) ,)
                ],
              ),
              SizedBox(height: 20.0,),
              allEvents(),
            ],

          ),


        ),
      ),







    );
  }
}
