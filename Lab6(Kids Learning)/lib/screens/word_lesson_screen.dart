import 'package:flutter/material.dart';
import '../models/lesson.dart';
import '../services/audio_service.dart';
import '../services/user_service.dart';

class WordLessonScreen extends StatefulWidget {
  final WordLesson lesson;

  const WordLessonScreen({Key? key, required this.lesson}) : super(key: key);

  @override
  State<WordLessonScreen> createState() => _WordLessonScreenState();
}

class _WordLessonScreenState extends State<WordLessonScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    
    // Speak the first word after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _speakCurrentWord();
    });
  }

  void _speakCurrentWord() {
    final word = widget.lesson.words[_currentIndex];
    AudioService.speak("${word.letter} for ${word.word}");
  }

  void _animateContent() {
    if (!_isAnimating) {
      setState(() {
        _isAnimating = true;
      });
      _animationController.forward().then((_) {
        _animationController.reverse().then((_) {
          setState(() {
            _isAnimating = false;
          });
        });
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson.title),
        backgroundColor: widget.lesson.color,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.lesson.words.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
                _speakCurrentWord();
              },
              itemBuilder: (context, index) {
                return _buildWordPage(widget.lesson.words[index]);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_currentIndex > 0)
                  ElevatedButton.icon(
                    onPressed: () {
                      AudioService.playSound('click');
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Previous'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.lesson.color,
                    ),
                  ),
                const SizedBox(width: 20),
                if (_currentIndex < widget.lesson.words.length - 1)
                  ElevatedButton.icon(
                    onPressed: () {
                      AudioService.playSound('click');
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Next'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.lesson.color,
                    ),
                  ),
                if (_currentIndex == widget.lesson.words.length - 1)
                  ElevatedButton.icon(
                    onPressed: () {
                      AudioService.playSound('success');
                      UserService.completeLesson(widget.lesson.id);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Complete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
              ],
            ),
          ),
          // Progress indicator
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.lesson.words.length,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == _currentIndex
                        ? widget.lesson.color
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _speakCurrentWord();
          _animateContent();
        },
        backgroundColor: widget.lesson.color,
        child: const Icon(Icons.volume_up),
      ),
    );
  }

  Widget _buildWordPage(Word word) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: widget.lesson.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    word.letter,
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: widget.lesson.color,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Text(
                "for",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: widget.lesson.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: widget.lesson.color, width: 2),
                ),
                child: Text(
                  word.word,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: widget.lesson.color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () {
              _speakCurrentWord();
              _animateContent();
            },
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    word.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          _getIconForWord(word.word),
                          size: 80,
                          color: widget.lesson.color,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            "${word.letter} is for ${word.word}",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Tap the image to hear it again",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForWord(String word) {
    final Map<String, IconData> icons = {
      'Apple': Icons.apple,
      'Banana': Icons.lunch_dining,
      'Cat': Icons.pets,
      'Dog': Icons.pets,
      'Elephant': Icons.pets,
      'Fish': Icons.set_meal,
      'Giraffe': Icons.pets,
      'House': Icons.home,
      'Ice Cream': Icons.icecream,
      'Jellyfish': Icons.water,
      'Kite': Icons.air,
      'Lion': Icons.pets,
      'Monkey': Icons.pets,
      'Nest': Icons.nest_cam_wired_stand,
      'Orange': Icons.pets,
      'Penguin': Icons.pets,
      'Queen': Icons.person,
      'Rabbit': Icons.pets,
      'Sun': Icons.wb_sunny,
      'Tree': Icons.park,
      'Umbrella': Icons.umbrella,
      'Van': Icons.airport_shuttle,
      'Whale': Icons.water,
      'Xylophone': Icons.music_note,
      'Yacht': Icons.directions_boat,
      'Zebra': Icons.pets,
    };

    return icons[word] ?? Icons.image;
  }
}

