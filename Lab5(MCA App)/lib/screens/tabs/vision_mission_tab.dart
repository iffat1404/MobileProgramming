import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/expandable_card.dart';

class VisionMissionTab extends StatelessWidget {
  const VisionMissionTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Vision & Mission',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ExpandableCard(
            title: 'Vision',
            subtitle: 'Our aspirations for the future',
            imageUrl: 'https://mca.spit.ac.in/assets/images/vision.jpg',
            expandedContent: _buildVisionContent(),
          ),
          const SizedBox(height: 16),
          ExpandableCard(
            title: 'Mission',
            subtitle: 'Our path to achieve our vision',
            imageUrl: 'https://mca.spit.ac.in/assets/images/mission.jpg',
            expandedContent: _buildMissionContent(),
          ),
          const SizedBox(height: 16),
          ExpandableCard(
            title: 'Program Educational Objectives',
            subtitle: 'What we aim to achieve',
            imageUrl: 'https://mca.spit.ac.in/assets/images/objectives.jpg',
            expandedContent: _buildPEOContent(),
          ),
          const SizedBox(height: 16),
          ExpandableCard(
            title: 'Program Outcomes',
            subtitle: 'Expected outcomes for our students',
            imageUrl: 'https://mca.spit.ac.in/assets/images/outcomes.jpg',
            expandedContent: _buildPOContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildVisionContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          'To build a strong technical foundation in Computer Science and Applications and an innovative approach to problem-solving, along with awareness about the role of IT in the societal development.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildMissionContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        _buildMissionPoint('1. To impart quality education in theory and practice of Computer Science and Applications.'),
        _buildMissionPoint('2. To provide a stimulating environment for the talented students to develop into quality technocrats.'),
        _buildMissionPoint('3. To train students to be industry ready and also to pursue higher studies.'),
        _buildMissionPoint('4. To inculcate professional ethics and social values in students.'),
      ],
    );
  }

  Widget _buildPEOContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        _buildMissionPoint('1. To prepare students for successful careers in industry, academia, research, entrepreneurial pursuit and consulting firms.'),
        _buildMissionPoint('2. To provide students with solid foundation in mathematical, computational and managerial techniques that will enable them to effectively use computer science and applications for challenging careers in industry and academia.'),
        _buildMissionPoint('3. To prepare students to contribute ethically to the society.'),
      ],
    );
  }

  Widget _buildPOContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        _buildMissionPoint('1. Apply knowledge of computing fundamentals, computing specialization, mathematics, and domain knowledge for the abstraction and conceptualization of computing models.'),
        _buildMissionPoint('2. Identify, formulate, research literature, and solve complex computing problems reaching substantiated conclusions using principles of mathematics and computing sciences.'),
        _buildMissionPoint('3. Design and evaluate solutions for complex computing problems, and design and evaluate systems, components, or processes that meet specified needs with appropriate consideration for public health and safety, cultural, societal, and environmental considerations.'),
        _buildMissionPoint('4. Use research-based knowledge including design of experiments, analysis and interpretation of data, and synthesis of the information to provide valid conclusions.'),
      ],
    );
  }

  Widget _buildMissionPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

