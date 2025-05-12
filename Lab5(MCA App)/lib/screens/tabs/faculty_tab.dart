import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/expandable_card.dart';
import '../../models/faculty.dart';

class FacultyTab extends StatelessWidget {
  const FacultyTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Faculty Information',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Meet our distinguished faculty members who bring expertise and dedication to the MCA department.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          ...facultyList.map((faculty) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ExpandableCard(
              title: faculty.name,
              subtitle: faculty.designation,
              imageUrl: faculty.imageUrl,
              expandedContent: _buildFacultyDetails(faculty),
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildFacultyDetails(Faculty faculty) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        if (faculty.qualification.isNotEmpty) ...[
          const Text(
            'Qualification:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.secondaryColor,
            ),
          ),
          Text(faculty.qualification),
          const SizedBox(height: 8),
        ],
        if (faculty.experience.isNotEmpty) ...[
          const Text(
            'Experience:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.secondaryColor,
            ),
          ),
          Text(faculty.experience),
          const SizedBox(height: 8),
        ],
        if (faculty.specialization.isNotEmpty) ...[
          const Text(
            'Specialization:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.secondaryColor,
            ),
          ),
          Text(faculty.specialization),
          const SizedBox(height: 8),
        ],
        if (faculty.email.isNotEmpty) ...[
          const Text(
            'Email:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.secondaryColor,
            ),
          ),
          Text(faculty.email),
        ],
      ],
    );
  }
}

