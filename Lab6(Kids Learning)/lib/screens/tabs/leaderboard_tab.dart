import 'package:flutter/material.dart';

class LeaderboardTab extends StatelessWidget {
  const LeaderboardTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample leaderboard data
    final List<Map<String, dynamic>> leaderboardData = [
      {
        'name': 'Emma',
        'avatar': 'assets/avatars/girl1.png',
        'score': 950,
        'quizzes': 12,
      },
      {
        'name': 'Noah',
        'avatar': 'assets/avatars/boy1.png',
        'score': 920,
        'quizzes': 11,
      },
      {
        'name': 'Olivia',
        'avatar': 'assets/avatars/girl1.png',
        'score': 880,
        'quizzes': 10,
      },
      {
        'name': 'Liam',
        'avatar': 'assets/avatars/boy1.png',
        'score': 850,
        'quizzes': 10,
      },
      {
        'name': 'Ava',
        'avatar': 'assets/avatars/girl1.png',
        'score': 820,
        'quizzes': 9,
      },
      {
        'name': 'William',
        'avatar': 'assets/avatars/boy1.png',
        'score': 790,
        'quizzes': 9,
      },
      {
        'name': 'Sophia',
        'avatar': 'assets/avatars/girl1.png',
        'score': 760,
        'quizzes': 8,
      },
      {
        'name': 'James',
        'avatar': 'assets/avatars/boy1.png',
        'score': 730,
        'quizzes': 8,
      },
      {
        'name': 'Isabella',
        'avatar': 'assets/avatars/girl1.png',
        'score': 700,
        'quizzes': 7,
      },
      {
        'name': 'Benjamin',
        'avatar': 'assets/avatars/boy1.png',
        'score': 670,
        'quizzes': 7,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Leaderboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'See who\'s at the top of the class!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 24),
            
            // Top 3 winners
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // 2nd place
                _buildTopThreeItem(
                  context, 
                  leaderboardData[1], 
                  2, 
                  Colors.grey.shade300, 
                  110
                ),
                const SizedBox(width: 16),
                // 1st place
                _buildTopThreeItem(
                  context, 
                  leaderboardData[0], 
                  1, 
                  Colors.amber.shade300, 
                  130
                ),
                const SizedBox(width: 16),
                // 3rd place
                _buildTopThreeItem(
                  context, 
                  leaderboardData[2], 
                  3, 
                  Colors.brown.shade300, 
                  90
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Rest of the leaderboard
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
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: leaderboardData.length - 3,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final rank = index + 4;
                  final data = leaderboardData[rank - 1];
                  
                  return ListTile(
                    leading: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$rank',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      data['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text('${data['quizzes']} quizzes completed'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${data['score']} pts',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopThreeItem(
    BuildContext context, 
    Map<String, dynamic> data, 
    int position, 
    Color color,
    double height,
  ) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: color,
              width: 4,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.person,
              size: 40,
              color: Colors.grey[600],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          data['name'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${data['score']} pts',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Center(
            child: Text(
              position == 1 ? '🥇' : position == 2 ? '🥈' : '🥉',
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

