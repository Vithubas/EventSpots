import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  /// Adds or updates a user's detail document with the given ID
  Future<void> addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    try {
      print("Saving user detail to Firestore: $userInfoMap");
      await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .set(userInfoMap);
      print("User detail saved successfully.");
    } catch (e) {
      print("Error saving user detail: $e");
    }
  }

  /// Adds or updates an event document with the given ID
  Future<void> addEvent(Map<String, dynamic> userInfoMap, String id) async {
    try {
      print("Saving event to Firestore: $userInfoMap");
      await FirebaseFirestore.instance
          .collection("Events")
          .doc(id)
          .set(userInfoMap);
      print("Event saved successfully.");
    } catch (e) {
      print("Error saving event: $e");
    }
  }

  /// Returns a stream of all events
  Future<Stream<QuerySnapshot>> getAllEvents() async {
    try {
      return FirebaseFirestore.instance.collection("Events").snapshots();
    } catch (e) {
      print("Error getting events stream: $e");
      rethrow;
    }
  }

  Future<void> addUserBooking(Map<String, dynamic> userInfoMap, String id) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Booking")
        .add(userInfoMap);
  }

  Stream<QuerySnapshot> getbookings(String id) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Booking")
        .snapshots();
  }




  Future<Stream<QuerySnapshot>> getEventCategories(String category) async {
    return FirebaseFirestore.instance
        .collection("Events")
        .where("Category", isEqualTo: category)  // pass .toLowerCase()
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getTickets() async {
    return FirebaseFirestore.instance
        .collection("Tickets")
    // pass .toLowerCase()
        .snapshots();
  }

  Future<QuerySnapshot> search(String searchKey) async {
    return await FirebaseFirestore.instance
        .collection("events")
        .where("SearchKey", isEqualTo: searchKey.substring(0, 1).toUpperCase())
        .get();
  }


}
