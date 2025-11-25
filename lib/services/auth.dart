import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkedinproject/Pages/bottomnavigationbar.dart';
import 'package:linkedinproject/services/database.dart';
import 'package:linkedinproject/services/shared_pref.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return auth.currentUser;
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // Fix: define googleSignInAccount first
    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      UserCredential result =
      await firebaseAuth.signInWithCredential(credential);

      User? userDetails = result.user;
      await SharedpreferenceHelper().saveUserEmail(userDetails!.email!);
      await SharedpreferenceHelper().saveUserName(userDetails.displayName!);
      await SharedpreferenceHelper().saveUserImage(userDetails.photoURL!);
      await SharedpreferenceHelper().saveUserID(userDetails.uid);
      
      print("Google Sign-In success: ${userDetails?.email}");

      if (userDetails != null) {
        Map<String, dynamic> userInfoMap = {
          "username": userDetails.displayName??'',
          "Image": userDetails.photoURL,
          "Email": userDetails.email,
          "Id": userDetails.uid,
        };

        await DatabaseMethods()
            .addUserDetail(userInfoMap, userDetails.uid)
            .then((value) {
          print("✅ Firestore write success.");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text("Registered Successfully!!"),
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Bottomnavigationbar()),
          );
        }).catchError((e) {
          print("🔥 Error in Firestore write: $e");
        });


      }

    }
  }

  Future SignOut()async{
    await FirebaseAuth.instance.signOut();
  }

  Future deleteuser()async{
    User? user=await FirebaseAuth.instance.currentUser;
    user?.delete();
  }
}
