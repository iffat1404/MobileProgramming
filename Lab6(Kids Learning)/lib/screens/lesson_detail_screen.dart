import 'package:flutter/material.dart';
import '../models/lesson.dart';
import '../services/audio_service.dart';
import '../services/user_service.dart';

class LessonDetailScreen extends StatefulWidget {
  final Lesson lesson;

  const LessonDetailScreen({Key? key, required this.lesson}) : super(key: key);

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> with SingleTickerProviderStateMixin {
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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    
    // Speak the first content item after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _speakCurrentContent();
    });
  }

  void _speakCurrentContent() {
    final content = widget.lesson.content[_currentIndex];
    if (widget.lesson.title.contains('Alphabet')) {
      AudioService.speak(content);
      Future.delayed(const Duration(milliseconds: 1000), () {
        final example = _getAlphabetExample(content);
        AudioService.speak("$content for $example");
      });
    } else if (widget.lesson.title.contains('Number')) {
      AudioService.speak(content);
    }
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
              itemCount: widget.lesson.content.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
                _speakCurrentContent();
              },
              itemBuilder: (context, index) {
                return _buildContentPage(widget.lesson.content[index]);
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
                if (_currentIndex < widget.lesson.content.length - 1)
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
                if (_currentIndex == widget.lesson.content.length - 1)
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
                widget.lesson.content.length,
                (index) => Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
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
          _speakCurrentContent();
          _animateContent();
        },
        backgroundColor: widget.lesson.color,
        child: const Icon(Icons.volume_up),
      ),
    );
  }

  Widget _buildContentPage(String content) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _speakCurrentContent();
              _animateContent();
            },
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: widget.lesson.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    content,
                    style: TextStyle(
                      fontSize: 120,
                      fontWeight: FontWeight.bold,
                      color: widget.lesson.color,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          if (widget.lesson.title.contains('Alphabet'))
            Column(
              children: [
                Text(
                  _getAlphabetExample(content),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/words/${_getAlphabetExample(content).toLowerCase()}.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            _getIconForWord(_getAlphabetExample(content)),
                            size: 60,
                            color: widget.lesson.color,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          if (widget.lesson.title.contains('Number'))
            Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    int.parse(content),
                    (index) => Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.star,
                        color: widget.lesson.color,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Count: $content",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: widget.lesson.color,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  String _getAlphabetExample(String letter) {
    final Map<String, String> examples = {
      'A': 'Apple',
      'B': 'Ball',
      'C': 'Cat',
      'D': 'Dog',
      'E': 'Elephant',
      'F': 'Fish',
      'G': 'Giraffe',
      'H': 'House',
      'I': 'Ice cream',
      'J': 'Jelly',
      'K': 'Kite',
      'L': 'Lion',
      'M': 'Monkey',
      'N': 'Nest',
      'O': 'Orange',
      'P': 'Penguin',
      'Q': 'Queen',
      'R': 'Rabbit',
      'S': 'Sun',
      'T': 'Tree',
      'U': 'Umbrella',
      'V': 'Van',
      'W': 'Water',
      'X': 'X-ray',
      'Y': 'Yacht',
      'Z': 'Zebra',
    };

    return examples[letter] ?? '';
  }

  IconData _getIconForWord(String word) {
    final Map<String, IconData> icons = {
      'Apple': Icons.apple,
      'Ball': Icons.sports_baseball,
      'Cat': Icons.pets,
      'Dog': Icons.pets,
      'Elephant': Icons.pets,
      'Fish': Icons.set_meal,
      'Giraffe': Icons.pets,
      'House': Icons.home,
      'Ice cream': Icons.icecream,
      'Jelly': Icons.fastfood,
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
      'Water': Icons.water_drop,
      'X-ray': Icons.medical_services,
      'Yacht': Icons.directions_boat,
      'Zebra': Icons.pets,
    };

    return icons[word] ?? Icons.image;
  }
}

