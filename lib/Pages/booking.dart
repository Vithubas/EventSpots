import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkedinproject/services/database.dart';
import 'package:linkedinproject/services/shared_pref.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  Stream<QuerySnapshot>? bookingStream;
  String? id;

  Future<void> loadUserData() async {
    id = await SharedpreferenceHelper().getUserID();
    print("User ID: $id"); // Debugging
    if (id != null) {
      bookingStream = await DatabaseMethods().getbookings(id!);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Widget allbookings() {
    if (bookingStream == null) {
      return Center(child: CircularProgressIndicator());
    }

    return StreamBuilder<QuerySnapshot>(
      stream: bookingStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No bookings found"));
        }

        return ListView.builder(
          padding: EdgeInsets.only(bottom: 20),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var ds = snapshot.data!.docs[index].data() as Map<String, dynamic>;

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black38, width: 2.0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_outlined, color: Colors.blue),
                      SizedBox(width: 20.0),
                      Text(
                        ds["Location"] ?? "No Location",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "images/img_4.png",
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ds["Event"] ?? "No Event",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 19.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              children: [
                                Icon(Icons.calendar_month, color: Colors.blue),
                                SizedBox(width: 5.0),
                                Text(
                                  ds["Date"] ?? "No Date",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              children: [
                                Icon(Icons.group, color: Colors.blue),
                                SizedBox(width: 10.0),
                                Text(
                                  ds["Number"] ?? "0",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(Icons.monetization_on, color: Colors.blue),
                                SizedBox(width: 10.0),
                                Text(
                                  "\$${ds["Total"] ?? "0.00"}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
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
        child: Column(
          children: [
            Text(
              "Bookings",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
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
                child: allbookings(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
