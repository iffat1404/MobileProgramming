import 'package:flutter/material.dart';

class ReviewDisplayScreen extends StatelessWidget {
  final String name;
  final String surname;
  final DateTime dob;
  final String address;
  final String email;
  final String phone;
  final String gender;
  final String review;
  final int rating;

  ReviewDisplayScreen({
    required this.name,
    required this.surname,
    required this.dob,
    required this.address,
    required this.email,
    required this.phone,
    required this.gender,
    required this.review,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("Name: $name $surname", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Date of Birth: ${dob.day}/${dob.month}/${dob.year}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Address: $address", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Email: $email", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Phone: $phone", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Gender: $gender", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Review: $review", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Rating: $rating Star(s)", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Return to the form screen
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text('Submit Another Review'),
            ),
          ],
        ),
      ),
    );
  }
}
