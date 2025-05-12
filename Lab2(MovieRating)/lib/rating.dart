import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final int rating;
  final ValueChanged<int> onRatingSelected;

  RatingStars({required this.rating, required this.onRatingSelected});

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      Color starColor;

      // Determine the color based on the rating
      if (rating == 1 || rating ==2) {
        starColor = Colors.red;
      } else if (rating == 3 ) {
        starColor = Colors.yellow;
      } else if (rating == 4 || rating == 5) {
        starColor = Colors.green;
      } else {
        starColor = Colors.amber; // Default color for ratings less than 2
      }

      stars.add(
        IconButton(
          icon: Icon(
            i <= rating ? Icons.star : Icons.star_border,
            color: starColor,
          ),
          onPressed: () {
            onRatingSelected(i);
          },
        ),
      );
    }
    return Row(children: stars);
  }
}