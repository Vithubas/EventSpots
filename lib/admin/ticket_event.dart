
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:linkedinproject/services/database.dart';

import '../Pages/detail_page.dart';

class TicketEvent extends StatefulWidget {
const TicketEvent({super.key});

@override
State<TicketEvent> createState() => _TicketEventState();
}

class _TicketEventState extends State<TicketEvent> {
Stream? ticketStream;

ontheload()async{
ticketStream =await DatabaseMethods().getTickets();
setState(() {

});
}

@override
void initState() {
ontheload();
super.initState();
}

Widget allTickets() {
return StreamBuilder(
stream: ticketStream,
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
    String userName = ds["Name"] ?? "User";
    String initial = userName.isNotEmpty ? userName[0].toUpperCase() : "?";
    String date = ds["Date"] ?? "Unknown Date";
    String event = ds["Event"] ?? "No Event";
    String price = ds["Total"] ?? "0.00";

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
              SizedBox(width: 10.0),
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
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Circle Avatar with initial
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.pink.shade200,
                  child: Text(
                    initial,
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                // Details Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Event: $event",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "Username: $userName",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "Date: $date",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "Price: \$${price}",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );


}
);
},
);
}
@override
Widget build(BuildContext context) {
return Scaffold(
body: Container(
margin: EdgeInsets.only(left: 10.0, top: 50.0),

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
Row(
children: [
GestureDetector(
onTap: (){
Navigator.pop(context);
},
child: Icon(Icons.arrow_back_ios_new_outlined)),
SizedBox(width:MediaQuery.of(context).size.width/4.0,),
Text(
"Event Tickets",
style: TextStyle(color: Colors.pink.shade400, fontSize: 25.0, fontWeight:FontWeight.bold ),
)
],),
SizedBox(height: 20.0,),
allTickets()
],
),
),
);
}
}