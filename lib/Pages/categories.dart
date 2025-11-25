import 'package:flutter/material.dart';
import 'package:linkedinproject/Pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:linkedinproject/services/database.dart';

import 'detail_page.dart';

class Categories extends StatefulWidget {
   String eventcategory;
  Categories({required this.eventcategory});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Stream? eventStream;

  getontheload() async {
    print("Fetching events for category: ${widget.eventcategory}");
    eventStream = await DatabaseMethods().getEventCategories(widget.eventcategory);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getontheload();
  }

  Widget allEvents() {
    return StreamBuilder(
      stream: eventStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data.docs;
        if (docs.isEmpty) {
          return Center(child: Text("No events found."));
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = docs[index];
            Map<String, dynamic> data = ds.data() as Map<String, dynamic>;

            try {
              String inputDate = ds["Date"];
              DateTime parseDate = DateTime.parse(inputDate);
              String formattedDate = DateFormat("MM-dd").format(parseDate);
              DateTime currentDate = DateTime.now();
              bool hasPassed = currentDate.isAfter(parseDate);

              final String name = data["Name"] ?? "Unnamed Event";
              final String price = data["Price"] ?? "0";
              final String location = data["Location"] ?? "Unknown";

              return hasPassed
                  ? Container()
                  : GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        date: ds["Date"],
                        detail: ds["Detail"],
                        image: ds["Image"],
                        location: ds["Location"],
                        name: ds["Name"],
                        price: ds["Price"],
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 20.0, left: 20.0),
                      width: MediaQuery.of(context).size.width,
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
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Padding(padding: const EdgeInsets.only(left: 20.0),
                    child:
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "\$ " + ds["Price"],
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(left: 20.0),
                        child:
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        Text(
                          location,
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    ),
                  ],

                ),
              );

            } catch (e) {
              print("Error parsing event: $e");
              return Container();
            }
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
            colors: [Color(0xFFFCE4EC), Color(0xFFFCE4EC), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios_new_outlined),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 3.5),
                  Text(
                    widget.eventcategory,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    Padding(padding: const EdgeInsets.all(8.0),
                    child:
                    allEvents()
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
