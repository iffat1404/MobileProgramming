import 'package:flutter/material.dart';
import 'project.dart';

void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFF262626),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _sections = [
    const ProfilePage(),
    const ProjectsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Portfolio"),
        backgroundColor: const Color(0xFFB375B0),
      ),
      body: _sections[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: const Color(0xFFB375B0),
        selectedItemColor:  Colors.white,
        unselectedItemColor: Color.fromARGB(255, 237, 200, 201),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Projects'),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Profile Container
              SizedBox(
                width: 320, // Fixed width for all containers
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assests/profile_image.jpg'),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Iffat Patel',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFBC2C3),
                        ),
                      ),
                      const Text(
                        'Software Developer',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

                           
              _buildEducationContainer(),

           
              _buildSkillsContainer(),

              // Hobbies Container
              _buildSectionContainer(
                'Hobbies',
                'Table Tennis, Swimming',
              ),

              // Contact Me Container
              _buildSectionContainer(
                'Contact Me',
                'Email: iffatspatel14@gmail.com\nPhone: 1234567890',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build section containers
  Widget _buildSectionContainer(String title, String content) {
    return SizedBox(
      width: 320, 
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(60, 242, 234, 234),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFBC2C3),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  // Education Container with icons and bullet points
  Widget _buildEducationContainer() {
    return SizedBox(
      width: 320, // Fixed width for all containers
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Education',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFBC2C3),
              ),
            ),
            const SizedBox(height: 8),
            Column(
              children: const [
                ListTile(
                  leading: Icon(Icons.school, color: Colors.white),
                  title: Text(
                    'Master of Computer Applications - Pursuing',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.school, color: Colors.white),
                  title: Text(
                    'Bachelors in Information Technology - 9.3 cgpa',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

 
  Widget _buildSkillsContainer() {
    return SizedBox(
      width: 320, 
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Skills',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFBC2C3),
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('• Flutter', style: TextStyle(fontSize: 18)),
                Text('• Dart', style: TextStyle(fontSize: 18)),
                Text('• Firebase', style: TextStyle(fontSize: 18)),
                Text('• Node.js', style: TextStyle(fontSize: 18)),
                Text('• Python', style: TextStyle(fontSize: 18)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}