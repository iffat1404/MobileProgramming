import 'package:flutter/material.dart';
import '../../models/quiz.dart';
import '../quiz_screen.dart';
import '../picture_word_quiz_screen.dart';
import '../../services/audio_service.dart';
import '../../services/user_service.dart';

class QuizTab extends StatefulWidget {
  const QuizTab({Key? key}) : super(key: key);

  @override
  State<QuizTab> createState() => _QuizTabState();
}

class _QuizTabState extends State<QuizTab> with SingleTickerProviderStateMixin {
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
    final List<Quiz> alphabetQuizzes = [
      Quiz(
        id: 'q1',
        title: 'Alphabet Quiz - Easy',
        description: 'Test your knowledge of the alphabet',
        icon: Icons.abc,
        color: Colors.blue,
        difficulty: 'Easy',
        questions: [
          QuizQuestion(
            question: 'Which letter comes after A?',
            options: ['B', 'C', 'D', 'E'],
            correctAnswer: 'B',
          ),
          QuizQuestion(
            question: 'Which letter comes before E?',
            options: ['A', 'B', 'C', 'D'],
            correctAnswer: 'D',
          ),
          QuizQuestion(
            question: 'What is the first letter of the alphabet?',
            options: ['Z', 'A', 'B', 'C'],
            correctAnswer: 'A',
          ),
          QuizQuestion(
            question: 'Which letter comes after D?',
            options: ['E', 'F', 'G', 'H'],
            correctAnswer: 'E',
          ),
          QuizQuestion(
            question: 'Which letter is a vowel?',
            options: ['B', 'C', 'D', 'I'],
            correctAnswer: 'I',
          ),
        ],
      ),
      Quiz(
        id: 'q3',
        title: 'Alphabet Quiz - Medium',
        description: 'More challenging alphabet questions',
        icon: Icons.abc,
        color: Colors.orange,
        difficulty: 'Medium',
        questions: [
          QuizQuestion(
            question: 'Which letter comes 3 letters after D?',
            options: ['E', 'F', 'G', 'H'],
            correctAnswer: 'G',
          ),
          QuizQuestion(
            question: 'Which of these is NOT a vowel?',
            options: ['A', 'E', 'F', 'I'],
            correctAnswer: 'F',
          ),
          QuizQuestion(
            question: 'What is the 10th letter of the alphabet?',
            options: ['I', 'J', 'K', 'L'],
            correctAnswer: 'J',
          ),
          QuizQuestion(
            question: 'Which letter comes between M and O?',
            options: ['L', 'N', 'P', 'Q'],
            correctAnswer: 'N',
          ),
          QuizQuestion(
            question: 'How many vowels are in the alphabet?',
            options: ['4', '5', '6', '7'],
            correctAnswer: '5',
          ),
        ],
      ),
    ];

    final List<Quiz> numberQuizzes = [
      Quiz(
        id: 'q2',
        title: 'Number Quiz - Easy',
        description: 'Test your knowledge of numbers 1-10',
        icon: Icons.numbers,
        color: Colors.green,
        difficulty: 'Easy',
        questions: [
          QuizQuestion(
            question: 'What comes after 3?',
            options: ['2', '4', '5', '6'],
            correctAnswer: '4',
          ),
          QuizQuestion(
            question: 'What comes before 7?',
            options: ['5', '6', '8', '9'],
            correctAnswer: '6',
          ),
          QuizQuestion(
            question: 'Which is greater: 4 or 9?',
            options: ['4', '9', 'Both equal', 'Neither'],
            correctAnswer: '9',
          ),
          QuizQuestion(
            question: 'What is 2 + 3?',
            options: ['4', '5', '6', '7'],
            correctAnswer: '5',
          ),
          QuizQuestion(
            question: 'How many fingers do you have on one hand?',
            options: ['4', '5', '6', '10'],
            correctAnswer: '5',
          ),
        ],
      ),
      Quiz(
        id: 'q4',
        title: 'Number Quiz - Medium',
        description: 'More challenging number questions',
        icon: Icons.numbers,
        color: Colors.purple,
        difficulty: 'Medium',
        questions: [
          QuizQuestion(
            question: 'What is 7 + 5?',
            options: ['10', '11', '12', '13'],
            correctAnswer: '12',
          ),
          QuizQuestion(
            question: 'What is 15 - 8?',
            options: ['5', '6', '7', '8'],
            correctAnswer: '7',
          ),
          QuizQuestion(
            question: 'What is 3 × 4?',
            options: ['7', '10', '12', '15'],
            correctAnswer: '12',
          ),
          QuizQuestion(
            question: 'Which is greater: 13 or 31?',
            options: ['13', '31', 'Both equal', 'Neither'],
            correctAnswer: '31',
          ),
          QuizQuestion(
            question: 'What comes 3 numbers after 17?',
            options: ['19', '20', '21', '22'],
            correctAnswer: '20',
          ),
        ],
      ),
    ];

    final List<PictureWordQuiz> wordQuizzes = [
      PictureWordQuiz(
        id: 'pw1',
        title: 'Picture Word Quiz - Easy',
        description: 'Name the objects in the pictures',
        icon: Icons.image,
        color: Colors.teal,
        difficulty: 'Easy',
        questions: [
          PictureWordQuestion(
            imagePath: 'assets/images/words/apple.png',
            correctAnswer: 'apple',
            hint: 'A fruit that is red or green',
          ),
          PictureWordQuestion(
            imagePath: 'assets/images/words/cat.png',
            correctAnswer: 'cat',
            hint: 'A furry pet that meows',
          ),
          PictureWordQuestion(
            imagePath: 'assets/images/words/dog.png',
            correctAnswer: 'dog',
            hint: 'A pet that barks',
          ),
          PictureWordQuestion(
            imagePath: 'assets/images/words/sun.png',
            correctAnswer: 'sun',
            hint: 'It shines in the sky during the day',
          ),
          PictureWordQuestion(
            imagePath: 'assets/images/words/tree.png',
            correctAnswer: 'tree',
            hint: 'It has leaves and grows tall',
          ),
        ],
      ),
      PictureWordQuiz(
        id: 'pw2',
        title: 'Picture Word Quiz - Medium',
        description: 'More challenging word identification',
        icon: Icons.image,
        color: Colors.deepOrange,
        difficulty: 'Medium',
        questions: [
          PictureWordQuestion(
            imagePath: 'assets/images/words/elephant.png',
            correctAnswer: 'elephant',
            hint: 'A large animal with a trunk',
          ),
          PictureWordQuestion(
            imagePath: 'assets/images/words/giraffe.png',
            correctAnswer: 'giraffe',
            hint: 'An animal with a very long neck',
          ),
          PictureWordQuestion(
            imagePath: 'assets/images/words/umbrella.png',
            correctAnswer: 'umbrella',
            hint: 'You use this when it rains',
          ),
          PictureWordQuestion(
            imagePath: 'assets/images/words/xylophone.png',
            correctAnswer: 'xylophone',
            hint: 'A musical instrument with colorful bars',
          ),
          PictureWordQuestion(
            imagePath: 'assets/images/words/zebra.png',
            correctAnswer: 'zebra',
            hint: 'An animal with black and white stripes',
          ),
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
              Tab(text: 'Alphabet'),
              Tab(text: 'Numbers'),
              Tab(text: 'Picture Words'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Alphabet Quizzes Tab
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Alphabet Quizzes',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Test your knowledge of letters',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: alphabetQuizzes.length,
                  itemBuilder: (context, index) {
                    return _buildQuizCard(context, alphabetQuizzes[index]);
                  },
                ),
              ],
            ),
          ),
          
          // Number Quizzes Tab
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Number Quizzes',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Test your knowledge of numbers',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: numberQuizzes.length,
                  itemBuilder: (context, index) {
                    return _buildQuizCard(context, numberQuizzes[index]);
                  },
                ),
              ],
            ),
          ),
          
          // Picture Word Quizzes Tab
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Picture Word Quizzes',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Identify words from pictures',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: wordQuizzes.length,
                  itemBuilder: (context, index) {
                    return _buildPictureWordQuizCard(context, wordQuizzes[index]);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizCard(BuildContext context, Quiz quiz) {
    final bool isCompleted = UserService.hasCompletedQuiz(quiz.id);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          AudioService.playSound('click');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizScreen(quiz: quiz),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: quiz.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  quiz.icon,
                  size: 30,
                  color: quiz.color,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quiz.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      quiz.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: quiz.color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            quiz.difficulty,
                            style: TextStyle(
                              fontSize: 12,
                              color: quiz.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${quiz.questions.length} Questions',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                        if (isCompleted) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Completed',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: quiz.color,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPictureWordQuizCard(BuildContext context, PictureWordQuiz quiz) {
    final bool isCompleted = UserService.hasCompletedQuiz(quiz.id);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          AudioService.playSound('click');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PictureWordQuizScreen(quiz: quiz),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: quiz.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  quiz.icon,
                  size: 30,
                  color: quiz.color,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quiz.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      quiz.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: quiz.color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            quiz.difficulty,
                            style: TextStyle(
                              fontSize: 12,
                              color: quiz.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${quiz.questions.length} Questions',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                        if (isCompleted) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Completed',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: quiz.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

