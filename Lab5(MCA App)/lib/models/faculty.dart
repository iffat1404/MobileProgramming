import 'package:flutter/material.dart';

class Faculty {
  final String name;
  final String designation;
  final String qualification;
  final String experience;
  final String specialization;
  final String email;
  final String imageUrl;

  Faculty({
    required this.name,
    required this.designation,
    required this.qualification,
    required this.experience,
    required this.specialization,
    required this.email,
    required this.imageUrl,
  });
}

final List<Faculty> facultyList = [
  Faculty(
    name: 'Dr. Dhananjay Kalbande',
    designation: 'Professor & Dean (Industry Relations)',
    qualification: 'Ph.D. (Computer Engineering), M.E. (Computer Engineering)',
    experience: '20+ years of teaching and research experience',
    specialization: 'Artificial Intelligence, Machine Learning, Data Science',
    email: 'drkalbande@spit.ac.in',
    imageUrl: 'assets/asset 2.jpeg',
  ),
  Faculty(
    name: 'Dr. Pooja Raundale',
    designation: 'Associate Professor & MCA Coordinator',
    qualification: 'Ph.D. (Computer Science), M.Tech (Computer Engineering)',
    experience: '15+ years of teaching experience',
    specialization: 'Database Systems, Data Mining, Big Data Analytics',
    email: 'pooja.raundale@spit.ac.in',
    imageUrl: 'assets/asset 3.jpeg',
  ),
  Faculty(
    name: 'Prof. Pallavi Thakur',
    designation: 'Assistant Professor',
    qualification: 'M.E. (Computer Engineering), Pursuing Ph.D.',
    experience: '10+ years of teaching experience',
    specialization: 'Web Technologies, Cloud Computing, IoT',
    email: 'pallavi.thakur@spit.ac.in',
    imageUrl: 'assets/asset 6.png',
  ),
  Faculty(
    name: 'Prof. Harshil Kanakia',
    designation: 'Assistant Professor',
    qualification: 'M.Tech (Computer Engineering)',
    experience: '8+ years of teaching and industry experience',
    specialization: 'Mobile Application Development, Software Engineering',
    email: 'harshil.kanakia@spit.ac.in',
    imageUrl: 'assets/asset 5.png',
  ),
  Faculty(
    name: 'Prof. Sakina Salmani',
    designation: 'Assistant Professor',
    qualification: 'M.E. Computers (DJSCOE), Pursuing Ph.D. in Computer (SPIT)',
    experience: '10+ years of teaching experience',
    specialization: 'Network Security, Ethical Hacking, User Experience Design, Mobile Programming (Android/lonic)',
    email: 'sakina_shaikh@spit.ac.in',
    imageUrl: 'assets/asset 7.png',
  ),
];

