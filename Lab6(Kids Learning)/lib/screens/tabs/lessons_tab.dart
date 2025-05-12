import 'package:flutter/material.dart';
import '../../models/lesson.dart';
import '../lesson_detail_screen.dart';
import '../word_lesson_screen.dart';
import '../../services/audio_service.dart';
import '../../services/user_service.dart';

class LessonsTab extends StatefulWidget {
  const LessonsTab({Key? key}) : super(key: key);

  @override
  State<LessonsTab> createState() => _LessonsTabState();
}

class _LessonsTabState extends State<LessonsTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Lesson> alphabetLessons = [
      Lesson(
        id: 'a1',
        title: 'Alphabet A-F',
        description: 'Learn the first 6 letters of the alphabet',
        icon: Icons.abc,
        color: Colors.red,
        content: const ['A', 'B', 'C', 'D', 'E', 'F'],
      ),
      Lesson(
        id: 'a2',
        title: 'Alphabet G-L',
        description: 'Learn letters G through L',
        icon: Icons.abc,
        color: Colors.green,
        content: const ['G', 'H', 'I', 'J', 'K', 'L'],
      ),
      Lesson(
        id: 'a3',
        title: 'Alphabet M-R',
        description: 'Learn letters M through R',
        icon: Icons.abc,
        color: Colors.blue,
        content: const ['M', 'N', 'O', 'P', 'Q', 'R'],
      ),
      Lesson(
        id: 'a4',
        title: 'Alphabet S-Z',
        description: 'Learn the last letters of the alphabet',
        icon: Icons.abc,
        color: Colors.purple,
        content: const ['S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'],
      ),
    ];

    final List<Lesson> numberLessons = [
      Lesson(
        id: 'n1',
        title: 'Numbers 1-5',
        description: 'Learn to count from 1 to 5',
        icon: Icons.numbers,
        color: Colors.orange,
        content: const ['1', '2', '3', '4', '5'],
      ),
      Lesson(
        id: 'n2',
        title: 'Numbers 6-10',
        description: 'Learn to count from 6 to 10',
        icon: Icons.numbers,
        color: Colors.teal,
        content: const ['6', '7', '8', '9', '10'],
      ),
      Lesson(
        id: 'n3',
        title: 'Numbers 11-15',
        description: 'Learn to count from 11 to 15',
        icon: Icons.numbers,
        color: Colors.pink,
        content: const ['11', '12', '13', '14', '15'],
      ),
      Lesson(
        id: 'n4',
        title: 'Numbers 16-20',
        description: 'Learn to count from 16 to 20',
        icon: Icons.numbers,
        color: Colors.amber,
        content: const ['16', '17', '18', '19', '20'],
      ),
    ];

    final List<WordLesson> wordLessons = [
      WordLesson(
        id: 'w1',
        title: 'Words A-F',
        description: 'Learn words starting with A to F',
        icon: Icons.menu_book,
        color: Colors.deepPurple,
        words: const [
          Word(letter: 'A', word: 'Apple', imagePath: 'assets/images/words/apple.png'),
          Word(letter: 'B', word: 'Banana', imagePath: 'assets/images/words/banana.png'),
          Word(letter: 'C', word: 'Cat', imagePath: 'assets/images/words/cat.png'),
          Word(letter: 'D', word: 'Dog', imagePath: 'assets/images/words/dog.png'),
          Word(letter: 'E', word: 'Elephant', imagePath: 'assets/images/words/elephant.png'),
          Word(letter: 'F', word: 'Fish', imagePath: 'assets/images/words/fish.png'),
        ],
      ),
      WordLesson(
        id: 'w2',
        title: 'Words G-L',
        description: 'Learn words starting with G to L',
        icon: Icons.menu_book,
        color: Colors.indigo,
        words: const [
          Word(letter: 'G', word: 'Giraffe', imagePath: 'assets/images/words/giraffe.png'),
          Word(letter: 'H', word: 'House', imagePath: 'assets/images/words/house.png'),
          Word(letter: 'I', word: 'Ice Cream', imagePath: 'assets/images/words/ice_cream.png'),
          Word(letter: 'J', word: 'Jellyfish', imagePath: 'assets/images/words/jellyfish.png'),
          Word(letter: 'K', word: 'Kite', imagePath: 'assets/images/words/kite.png'),
          Word(letter: 'L', word: 'Lion', imagePath: 'assets/images/words/lion.png'),
        ],
      ),
      WordLesson(
        id: 'w3',
        title: 'Words M-R',
        description: 'Learn words starting with M to R',
        icon: Icons.menu_book,
        color: Colors.teal,
        words: const [
          Word(letter: 'M', word: 'Monkey', imagePath: 'assets/images/words/monkey.png'),
          Word(letter: 'N', word: 'Nest', imagePath: 'assets/images/words/nest.png'),
          Word(letter: 'O', word: 'Orange', imagePath: 'assets/images/words/orange.png'),
          Word(letter: 'P', word: 'Penguin', imagePath: 'assets/images/words/penguin.png'),
          Word(letter: 'Q', word: 'Queen', imagePath: 'assets/images/words/queen.png'),
          Word(letter: 'R', word: 'Rabbit', imagePath: 'assets/images/words/rabbit.png'),
        ],
      ),
      WordLesson(
        id: 'w4',
        title: 'Words S-Z',
        description: 'Learn words starting with S to Z',
        icon: Icons.menu_book,
        color: Colors.deepOrange,
        words: const [
          Word(letter: 'S', word: 'Sun', imagePath: 'assets/images/words/sun.png'),
          Word(letter: 'T', word: 'Tree', imagePath: 'assets/images/words/tree.png'),
          Word(letter: 'U', word: 'Umbrella', imagePath: 'assets/images/words/umbrella.png'),
          Word(letter: 'V', word: 'Van', imagePath: 'assets/images/words/van.png'),
          Word(letter: 'W', word: 'Whale', imagePath: 'assets/images/words/whale.png'),
          Word(letter: 'X', word: 'Xylophone', imagePath: 'assets/images/words/xylophone.png'),
          Word(letter: 'Y', word: 'Yacht', imagePath: 'assets/images/words/yacht.png'),
          Word(letter: 'Z', word: 'Zebra', imagePath: 'assets/images/words/zebra.png'),
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          color: Colors.lightBlue[50],
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: const [
              Tab(text: 'Alphabets'),
              Tab(text: 'Numbers'),
              Tab(text: 'Words'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Alphabets Tab
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Learn Alphabets',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: alphabetLessons.length,
                  itemBuilder: (context, index) {
                    return _buildLessonCard(context, alphabetLessons[index]);
                  },
                ),
              ],
            ),
          ),
          
          // Numbers Tab
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Learn Numbers',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: numberLessons.length,
                  itemBuilder: (context, index) {
                    return _buildLessonCard(context, numberLessons[index]);
                  },
                ),
              ],
            ),
          ),
          
          // Words Tab
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Learn Words',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: wordLessons.length,
                  itemBuilder: (context, index) {
                    return _buildWordLessonCard(context, wordLessons[index]);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonCard(BuildContext context, Lesson lesson) {
    final bool isCompleted = UserService.hasCompletedLesson(lesson.id);
    
    return GestureDetector(
      onTap: () {
        AudioService.playSound('click');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LessonDetailScreen(lesson: lesson),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                lesson.color.withOpacity(0.7),
                lesson.color,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      lesson.icon,
                      size: 40,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      lesson.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lesson.description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (isCompleted)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: lesson.color,
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWordLessonCard(BuildContext context, WordLesson lesson) {
    final bool isCompleted = UserService.hasCompletedLesson(lesson.id);
    
    return GestureDetector(
      onTap: () {
        AudioService.playSound('click');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WordLessonScreen(lesson: lesson),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                lesson.color.withOpacity(0.7),
                lesson.color,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      lesson.icon,
                      size: 40,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      lesson.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lesson.description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (isCompleted)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: lesson.color,
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

