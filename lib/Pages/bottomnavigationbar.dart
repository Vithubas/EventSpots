import 'package:flutter/material.dart';
import 'package:linkedinproject/Pages/Profile.dart';
import 'package:linkedinproject/Pages/booking.dart';
import 'package:linkedinproject/Pages/home.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'home.dart';


class Bottomnavigationbar extends StatefulWidget {
  const Bottomnavigationbar({super.key});

  @override
  State<Bottomnavigationbar> createState() => _BottomnavigationbarState();
}

class _BottomnavigationbarState extends State<Bottomnavigationbar> {
  late List<Widget> pages;
  late home homepage;
  late Booking booking;
  late Profile profile;
  int currentTabIndex=0;
  @override

  void initState(){
    homepage = home();
    booking = Booking();
    profile = Profile();
    pages = [homepage, booking, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.pink.shade600,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index){
          setState(() {
            currentTabIndex=index;
          });

        },
        items: [
          Icon(Icons.home_outlined, color: Colors.white, size: 30.0,),
          Icon(Icons.book, color: Colors.white,size: 30.0),
          Icon(Icons.person_outline, color: Colors.white,size: 30.0),

        ],
      ),
      body: pages[ currentTabIndex],


    );
  }
}
