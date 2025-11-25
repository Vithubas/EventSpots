import 'package:flutter/material.dart';
import 'package:linkedinproject/Pages/signup.dart';
import 'package:linkedinproject/services/auth.dart';
import 'package:linkedinproject/services/shared_pref.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? image,name,email,id;

  getthesharedoref()async{
    id = await SharedpreferenceHelper().getUserID();
    image= await SharedpreferenceHelper().getUserImage();
    email = await SharedpreferenceHelper().getUserEmail();
    name= await SharedpreferenceHelper().getUserName();
    setState(() {

    });
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  ontheload()async{
    await getthesharedoref();
    setState(() {

    });

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
              "Profile",
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
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.pink.shade200,
                      child: Text(
                        'V',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0,),
                    Container(
                      padding: EdgeInsets.only(
                        left: 10.0, top: 10.0, bottom: 10.0,
                      ),
                      margin: EdgeInsets.only(left: 30.0,right: 30.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.5),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.blue,
                            size: 30.0,
                          ),
                          SizedBox(width: 20.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                              Text(
                                "Vithurshana Baskaran",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],

                          ),

                        ],
                      ),
                    ),
                      SizedBox(height: 40.0,),
                      Container(
                    padding: EdgeInsets.only(
                    left: 10.0, top: 10.0, bottom: 10.0,
                    ),
                margin: EdgeInsets.only(left: 30.0,right: 30.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(width: 1.5),
                    borderRadius: BorderRadius.circular(20)
                ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.mail,
                            color: Colors.blue,
                            size: 30.0,
                          ),
                          SizedBox(width: 20.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )
                            ),
                            Text(
                              "Vithurshanabaskaran9@gmail.com",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],

                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 40.0,),
                    GestureDetector(
                        onTap: () {
                          AuthMethods().SignOut().then((value) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()));
                          }
                          );
                        },

                        child:
                        Container(
                          padding: EdgeInsets.only(
                            left: 10.0, top: 10.0, bottom: 10.0,
                          ),
                          margin: EdgeInsets.only(left: 30.0,right: 30.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1.5),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.contact_mail_outlined, color: Colors.blue,size: 30.0,),
                              SizedBox(width: 20.0,),
                              Text(
                                "Contact Us",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Padding(padding: const EdgeInsets.only(right: 20.0),
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.blue,

                                ),


                              )
                            ],
                          ),
                        )
                    ),

                    SizedBox(height: 40.0,),
                    GestureDetector(
                      onTap: () {
                        AuthMethods().SignOut().then((value) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup()));
                        }
                        );
                      },

child:
                    Container(
                      padding: EdgeInsets.only(
                        left: 10.0, top: 10.0, bottom: 10.0,
                      ),
                      margin: EdgeInsets.only(left: 30.0,right: 30.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.5),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.logout, color: Colors.blue,size: 30.0,),
                          SizedBox(width: 20.0,),
                          Text(
                            "LogOut",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
Padding(padding: const EdgeInsets.only(right: 20.0),
  child: Icon(
    Icons.arrow_forward_ios_outlined,
    color: Colors.blue,

  ),


     )
                        ],
                      ),
                    )
                    ),
                    SizedBox(height: 40.0,),
                    GestureDetector(
                        onTap: () {
                          AuthMethods().deleteuser().then((value) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()));
                          }
                          );
                        },

                        child:
                        Container(
                          padding: EdgeInsets.only(
                            left: 10.0, top: 10.0, bottom: 10.0,
                          ),
                          margin: EdgeInsets.only(left: 30.0,right: 30.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1.5),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.blue,size: 30.0,),
                              SizedBox(width: 20.0,),
                              Text(
                                "Delete Account",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Padding(padding: const EdgeInsets.only(right: 20.0),
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.blue,

                                ),


                              )
                            ],
                          ),
                        )
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
