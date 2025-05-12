import 'package:flutter/material.dart';
import 'display.dart';
import 'rating.dart';

class ReviewFormScreen extends StatefulWidget {
  @override
  _ReviewFormScreenState createState() => _ReviewFormScreenState();
}

class _ReviewFormScreenState extends State<ReviewFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form field variables
  String name = '';
  String surname = '';
  DateTime? dob;
  String address = '';
  String email = '';
  String phone = '';
  String gender = 'Male';
  String review = '';
  int rating = 0;

  // Controller for the DOB text field
  final TextEditingController dobController = TextEditingController();

  // Opens a date picker dialog
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dob ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != dob) {
      setState(() {
        dob = picked;
        dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  // Submits the form and navigates to the display screen
  void _submitForm() {
    if (_formKey.currentState!.validate() && rating > 0) {
      _formKey.currentState!.save();

      // Show snackbar for successful submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review submitted successfully!')),
      );

      // Delay briefly, then navigate to the ReviewDisplayScreen
      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReviewDisplayScreen(
              name: name,
              surname: surname,
              dob: dob!,
              address: address,
              email: email,
              phone: phone,
              gender: gender,
              review: review,
              rating: rating,
            ),
          ),
        );
      });
    } else {
      // If rating is not selected, show an alert dialog.
      if (rating == 0) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Validation Error'),
            content: Text('Please select a rating.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
        );
      }
    }
  }

  // Shows an alert dialog when the fan button is pressed
  void _showFanDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Fan Alert'),
        content: Text('Thanks for being a fan!'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Movie Review'),
        actions: [
          // Static fan button in the app bar
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: _showFanDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // First Name
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name *'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => name = value!.trim(),
              ),
              // Surname
              TextFormField(
                decoration: InputDecoration(labelText: 'Surname *'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => surname = value!.trim(),
              ),
              // Date of Birth
              TextFormField(
                controller: dobController,
                decoration: InputDecoration(
                  labelText: 'Date of Birth *',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              // Address
              TextFormField(
                decoration: InputDecoration(labelText: 'Address *'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => address = value!.trim(),
              ),
              // Email
              TextFormField(
                decoration: InputDecoration(labelText: 'Email ID *'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value))
                    return 'Enter a valid email';
                  return null;
                },
                onSaved: (value) => email = value!.trim(),
              ),
              // Phone Number
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number *'),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => phone = value!.trim(),
              ),
              // Gender radio buttons
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Gender *'),
                    ListTile(
                      title: Text('Male'),
                      leading: Radio<String>(
                        value: 'Male',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('Female'),
                      leading: Radio<String>(
                        value: 'Female',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('Other'),
                      leading: Radio<String>(
                        value: 'Other',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Review Text
              TextFormField(
                decoration: InputDecoration(labelText: 'Review *'),
                maxLines: 4,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => review = value!.trim(),
              ),
              // Rating Stars using a custom component
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Rating *'),
                    RatingStars(
                      rating: rating,
                      onRatingSelected: (selectedRating) {
                        setState(() {
                          rating = selectedRating;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit Review'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
