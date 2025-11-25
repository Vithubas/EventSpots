import 'package:flutter/material.dart';
import 'package:linkedinproject/services/auth.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      Container(

        child: Column(
          children: [

            Image.asset("images/homescreen2.png",height: 420,),
            SizedBox(height: 40.0,),
            Text(
              "Event Booking App",
              style: TextStyle(
                color: Colors.pinkAccent.shade400,
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40.0,),
            Text(
              "Discover, book and experience ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),

            Text(
              "unforgettable moments effortlessly! ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
           SizedBox(height: 80.0,),
           GestureDetector(
             onTap: (){
               AuthMethods().signInWithGoogle(context);
             },
           child: Container(
             height: 80,
             margin: EdgeInsets.only(left: 30.0, right: 30.0),
             decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(15)),

             child: Row(

              mainAxisAlignment: MainAxisAlignment.center,
            children: [ Image.asset("images/google.png",height: 30,width: 30, fit: BoxFit.cover,),
              SizedBox(width: 20.0,),
              Text(
                "Sign in with Google",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
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
