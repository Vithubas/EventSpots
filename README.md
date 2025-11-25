 🎉 EventSpot

A centralized platform to explore, discover, and book events with secure online payments.

EventSpot is a Flutter application powered by Firebase and Stripe that allows users to easily discover events happening around them and book tickets instantly. Admins can upload events with details such as name, category, location, and ticket price. Users can view events by category, see detailed information, and complete ticket purchases seamlessly.



 📌 Overview

Many people only hear about events through scattered sources like WhatsApp chats, Facebook posts, or social media stories. This leads to missed opportunities and limited awareness of what’s happening around them.
EventSpot solves this problem by providing a single platform where:

 Users can discover all events in one place
 Events are organized by categories
 Users can read full event details
 Tickets can be booked instantly
 Payments are processed securely using Stripe
 Admins can upload new events easily

🎥 Demo Video
https://github.com/user-attachments/assets/5d2a74c9-7d6d-446d-85ae-c3893fe6ba34


 🚀 Features

 👩‍💼 Admin Features
 Login with username
 Upload new events with:

  * Event name
  * Category (Food, Festival, Music, Clothing, etc.)
  * Venue / Location
  * Ticket price
  * Description
  * Event image
  * Manage existing events


  👤 User Features

* View all available events
* Filter by category
* Open detailed event pages
* Book ticket(s) with quantity selection
* Pay securely using Stripe
* Receive booking confirmation


🛠️ Technology Stack

 Flutter
 Firebase
 Stripe

🔥 Why EventSpot?

EventSpot eliminates the frustration of missing events due to scattered information sources by:
* Providing a centralized event discovery app
* Giving users immediate access to upcoming events
* Making ticket booking fast, easy, and secure
* Helping event organizers broadcast their events with less effort
This app is useful for students, families, travelers, event organizers, music lovers, festival-goers, and anyone looking to stay updated.

 📲 How It Works
 
 1️⃣ Admin Uploads an Event

Admin fills in:

* Name
* Category
* Location
* Description
* Ticket price
* Event image

And clicks Upload → Event is stored in Firestore.

 2️⃣ Users Explore Events

Users can browse by category, scroll event lists, and open detailed pages.

3️⃣ Users Book Tickets

* Select number of tickets
* Redirected to Stripe
* Secure payment
* Receives booking confirmation

📦 Setup Instructions

 1. Clone the Repository

git clone https://github.com/Vithubas/Event_booking.git

 2. Install Dependencies
    
flutter pub get


 3. Add Firebase Configuration

Place the following files in their respective locations:
* `google-services.json` (Android)
* `GoogleService-Info.plist` (iOS)

 4. Add Stripe Keys
Add your API keys inside an `.env` or constants file.

 5. Run the App
flutter run

📚 Future Enhancements

* Push notifications for new events
* AI-based recommendations
* Map view for event locations
* Event reminders
* Ratings & reviews
* Multiple admin accounts
* Dark mode



