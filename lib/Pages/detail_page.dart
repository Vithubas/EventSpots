import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart'; // Make sure you have this package
import 'package:linkedinproject/services/data.dart';
import 'package:linkedinproject/services/data.dart';
import 'package:linkedinproject/services/database.dart';
import 'package:linkedinproject/services/shared_pref.dart';// Ensure this contains `secretKey`

class DetailPage extends StatefulWidget {
  final String image, name, location, date, detail, price;
  DetailPage({
    required this.date,
    required this.image,
    required this.detail,
    required this.location,
    required this.name,
    required this.price,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Map<String, dynamic>? paymentIntent;
  int ticket = 1;
  int total=0;
  String? name, image,id;

  @override
  void initState() {
    total=int.parse(widget.price);
    ontheload();
    super.initState();
  }

  ontheload()async{
    name = await SharedpreferenceHelper().getUserName();
    image=await SharedpreferenceHelper().getUserImage();
    id= await SharedpreferenceHelper().getUserID();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  "images/img_4.png",
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.only(top: 40.0, left: 20.0),
                          child: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20.0),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.calendar_month_rounded, color: Colors.white),
                                SizedBox(width: 10.0),
                                Text(
                                  widget.date,
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(Icons.location_on, color: Colors.white),
                                SizedBox(width: 10.0),
                                Text(
                                  widget.location,
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "About Event",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                widget.detail,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Text(
                    "Number of Tickets",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 40.0),
                  Container(
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            total = total+ int.parse(widget.price);
                            ticket++;
                            setState(() {});
                          },
                          child: Text("+", style: TextStyle(fontSize: 25.0)),
                        ),
                        Text(ticket.toString(), style: TextStyle(fontSize: 25.0, color: Colors.pink.shade600)),
                        GestureDetector(
                          onTap: () {
                            total = total- int.parse(widget.price);
                            if (ticket > 1) {
                              ticket--;
                              setState(() {});
                            }
                          },
                          child: Text("-", style: TextStyle(fontSize: 25.0)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Text(
                    "Amount: \$"+ total.toString(),
                    style: TextStyle(fontSize: 23.0, color: Colors.pink.shade600, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 90.0),
                  GestureDetector(
                    onTap: () async {
                      await makePayment((int.parse(widget.price) * ticket).toString());
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(color: Colors.pink.shade600),
                      child: Center(child: Text("Book Now", style: TextStyle(color: Colors.white))),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, "USD"); // Use ISO currency code
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'eventbookingapp',
        ),
      );
      await displayPaymentSheet(amount);
    } catch (e, s) {
      print('exception: $e $s');
    }
  }

  Future<void> displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value)async {
        Map<String, dynamic>bookingdetail={
          "Number": ticket.toString(),
          "Total":total.toString(),
          "Event":widget.name,
          "Location":widget.location,
          "Date":widget.date,
          "Name":name,
          "Image":image,
          "EventImage":widget.image,

        };
        await DatabaseMethods().addUserBooking(bookingdetail, id!).then((value)async{



        });
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 10),
                Text("Payment Successful"),
              ],
            ),
          ),
        );
        paymentIntent = null;
      }).onError((error, stackTrace) {
        print("Error is : $error $stackTrace");
      });
    } on StripeException catch (e) {
      print("Error is : $e");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(content: Text("Cancelled")),
      );
    } catch (e) {
      print('$e');
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey', // Import this from your data.dart
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('Error charging user: ${err.toString()}');
      return null;
    }
  }

  String calculateAmount(String amount) {
    final calculatedAmount = int.parse(amount) * 100; // Stripe accepts amount in paisa
    return calculatedAmount.toString();
  }
}
