import 'package:flutter/material.dart';
import '../../services/user_service.dart';
import '../../services/audio_service.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late Map<String, dynamic> _userData;
  final List<String> _avatarOptions = [
    'assets/avatars/boy1.png',
    'assets/avatars/boy1.png',
    'assets/avatars/boy1.png',
    'assets/avatars/girl1.png',
    'assets/avatars/girl1.png',
    'assets/avatars/girl1.png',
    'assets/avatars/robot1.png',
    'assets/avatars/robot2.png',
  ];
  
  final Map<String, Color> _badgeColors = {
    'Alphabet Master': Colors.blue,
    'Number Genius': Colors.green,
    'Quiz Champion': Colors.orange,
    'Fast Learner': Colors.purple,
    'Perfect Score': Colors.red,
  };
  
  final Map<String, bool> _achievements = {
    'Complete 5 Alphabet Lessons': true,
    'Complete 5 Number Lessons': true,
    'Score 100% on any quiz': true,
    'Complete 10 quizzes': false,
    'Earn 500 points': true,
    'Complete all alphabet lessons': false,
    'Complete all number lessons': false,
    'Score 100% on 5 quizzes': false,
  };

  @override
  void initState() {
    super.initState();
    _userData = UserService.getUserData();
  }

  void _refreshUserData() {
    setState(() {
      _userData = UserService.getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Avatar
                  GestureDetector(
                    onTap: _showAvatarPicker,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.blue.shade100,
                          backgroundImage: _userData['avatar'] != null
                              ? AssetImage(_userData['avatar'])
                              : null,
                          onBackgroundImageError: (exception, stackTrace) {
                            // If image fails to load, show icon
                          },
                          child: _userData['avatar'] == null
                              ? Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.blue.shade700,
                                )
                              : null,
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _userData['name'] ?? 'Student',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        onPressed: _showNameEditor,
                      ),
                    ],
                  ),
                  Text(
                    '${_userData['age'] ?? 7} years old',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('Points', '${_userData['points'] ?? 0}'),
                      _buildStatItem('Quizzes', '${(_userData['completedQuizzes'] as List?)?.length ?? 0}'),
                      _buildStatItem('Lessons', '${(_userData['completedLessons'] as List?)?.length ?? 0}'),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Badges section
            const Text(
              'My Badges',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _badgeColors.length,
                itemBuilder: (context, index) {
                  final badge = _badgeColors.keys.elementAt(index);
                  final color = _badgeColors.values.elementAt(index);
                  final hasBadge = (_userData['badges'] as List?)?.contains(badge) ?? false;
                  return _buildBadge(badge, color, hasBadge);
                },
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Achievements section
            const Text(
              'Achievements',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 12),
            ...(_achievements.entries.map((entry) {
              final hasAchievement = (_userData['achievements'] as List?)?.contains(entry.key) ?? false;
              return _buildAchievementItem(entry.key, hasAchievement);
            }).toList()),
            
            const SizedBox(height: 24),
            
            // Settings
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.volume_up, color: Colors.blue),
                    title: const Text('Sound Effects'),
                    trailing: Switch(
                      value: !AudioService.isMuted(),
                      onChanged: (value) {
                        setState(() {
                          AudioService.setMuted(!value);
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.help, color: Colors.blue),
                    title: const Text('Help & Support'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      AudioService.playSound('click');
                      // Show help dialog
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Help & Support'),
                          content: const Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Need help with the app?', style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 8),
                              Text('• Tap on lessons to learn letters, numbers, and words'),
                              Text('• Take quizzes to test your knowledge'),
                              Text('• Earn points and badges for your achievements'),
                              Text('• Customize your profile with different avatars'),
                              SizedBox(height: 16),
                              Text('For more help, ask a parent or teacher.'),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.info, color: Colors.blue),
                    title: const Text('About'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      AudioService.playSound('click');
                      // Show about dialog
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('About Kids Learning App'),
                          content: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Version 1.0.0'),
                              SizedBox(height: 8),
                              Text('A fun educational app for children to learn alphabets, numbers, and words.'),
                              SizedBox(height: 16),
                              Text('© 2023 Kids Learning App'),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(String title, Color color, bool earned) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: earned ? color.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: earned ? color : Colors.grey.shade300,
                width: 2,
              ),
            ),
            child: Icon(
              earned ? Icons.star : Icons.lock,
              color: earned ? color : Colors.grey.shade400,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: earned ? Colors.black87 : Colors.grey,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementItem(String title, bool achieved) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: achieved ? Colors.green : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: achieved ? Colors.green : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Icon(
              achieved ? Icons.check : Icons.lock,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: achieved ? FontWeight.bold : FontWeight.normal,
                color: achieved ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showNameEditor() {
    showDialog(
      context: context,
      builder: (context) {
        String newName = _userData['name'] ?? '';
        int newAge = _userData['age'] ?? 7;
        
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: newName),
                onChanged: (value) {
                  newName = value;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Age: '),
                  DropdownButton<int>(
                    value: newAge,
                    items: List.generate(10, (index) => index + 4)
                        .map((age) => DropdownMenuItem<int>(
                              value: age,
                              child: Text('$age'),
                            ))
                        .toList(),
                    onChanged: (value) {
                      newAge = value!;
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await UserService.updateUserData({
                  'name': newName,
                  'age': newAge,
                });
                Navigator.pop(context);
                _refreshUserData();
                AudioService.playSound('success');
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showAvatarPicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose Avatar'),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _avatarOptions.length,
              itemBuilder: (context, index) {
                final avatar = _avatarOptions[index];
                return GestureDetector(
                  onTap: () async {
                    await UserService.updateUserData({
                      'avatar': avatar,
                    });
                    Navigator.pop(context);
                    _refreshUserData();
                    AudioService.playSound('success');
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    backgroundImage: AssetImage(avatar),
                    onBackgroundImageError: (exception, stackTrace) {
                      // If image fails to load
                    },
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

