import 'package:flutter/material.dart';
import '../models/quiz.dart';
import '../services/audio_service.dart';
import '../services/user_service.dart';

class PictureWordQuizScreen extends StatefulWidget {
  final PictureWordQuiz quiz;

  const PictureWordQuizScreen({Key? key, required this.quiz}) : super(key: key);

  @override
  State<PictureWordQuizScreen> createState() => _PictureWordQuizScreenState();
}

class _PictureWordQuizScreenState extends State<PictureWordQuizScreen> {
  int _currentQuestionIndex = 0;
  List<String> _userAnswers = [];
  bool _isCorrect = false;
  bool _showResult = false;
  bool _showHint = false;
  final TextEditingController _answerController = TextEditingController();
  final FocusNode _answerFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _userAnswers = List.filled(widget.quiz.questions.length, '');
    
    // Speak the instruction
    Future.delayed(const Duration(milliseconds: 500), () {
      AudioService.speak("Look at the picture and type the word");
    });
  }

  @override
  void dispose() {
    _answerController.dispose();
    _answerFocusNode.dispose();
    super.dispose();
  }

  void _checkAnswer() {
    final currentQuestion = widget.quiz.questions[_currentQuestionIndex];
    final userAnswer = _answerController.text.trim().toLowerCase();
    
    setState(() {
      _userAnswers[_currentQuestionIndex] = userAnswer;
      _isCorrect = userAnswer == currentQuestion.correctAnswer.toLowerCase();
      _showResult = true;
    });
    
    if (_isCorrect) {
      AudioService.playSound('correct');
      AudioService.speak("Correct! It's a ${currentQuestion.correctAnswer}");
    } else {
      AudioService.playSound('incorrect');
      AudioService.speak("Try again. It's a ${currentQuestion.correctAnswer}");
    }
    
    // Wait a moment to show the correct/incorrect feedback
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (_currentQuestionIndex < widget.quiz.questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _showResult = false;
          _showHint = false;
          _answerController.clear();
        });
        _answerFocusNode.requestFocus();
      } else {
        // Quiz completed
        _finishQuiz();
      }
    });
  }

  void _finishQuiz() {
    int correctAnswers = 0;
    for (int i = 0; i < widget.quiz.questions.length; i++) {
      if (_userAnswers[i].toLowerCase() == widget.quiz.questions[i].correctAnswer.toLowerCase()) {
        correctAnswers++;
      }
    }
    
    UserService.completeQuiz(
      widget.quiz.id, 
      correctAnswers, 
      widget.quiz.questions.length
    );
    
    Navigator.pop(context);
    
    // Show result dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Completed!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You got $correctAnswers out of ${widget.quiz.questions.length} correct!',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Icon(
              correctAnswers >= widget.quiz.questions.length / 2
                  ? Icons.sentiment_very_satisfied
                  : Icons.sentiment_dissatisfied,
              color: correctAnswers >= widget.quiz.questions.length / 2
                  ? Colors.green
                  : Colors.red,
              size: 60,
            ),
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
  }

  void _showHintMessage() {
    setState(() {
      _showHint = true;
    });
    
    AudioService.speak(widget.quiz.questions[_currentQuestionIndex].hint);
  }

  void _speakQuestion() {
    AudioService.speak("What is this? Type the word.");
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.quiz.questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz.title),
        backgroundColor: widget.quiz.color,
      ),
      body: Column(
        children: [
          // Progress indicator
          LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / widget.quiz.questions.length,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(widget.quiz.color),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${_currentQuestionIndex + 1}/${widget.quiz.questions.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: widget.quiz.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.quiz.difficulty,
                    style: TextStyle(
                      color: widget.quiz.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Question
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'What is this? Type the word.',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  
                  // Image
                  GestureDetector(
                    onTap: _speakQuestion,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          currentQuestion.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 80,
                                color: Colors.grey[400],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Answer input
                  TextField(
                    controller: _answerController,
                    focusNode: _answerFocusNode,
                    decoration: InputDecoration(
                      labelText: 'Type your answer',
                      hintText: 'What is this?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.edit),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: _answerController.text.isNotEmpty ? _checkAnswer : null,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: _showResult
                              ? (_isCorrect ? Colors.green : Colors.red)
                              : Colors.grey.shade400,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: _showResult
                              ? (_isCorrect ? Colors.green : Colors.red)
                              : widget.quiz.color,
                          width: 2,
                        ),
                      ),
                    ),
                    onSubmitted: (_) => _checkAnswer(),
                    enabled: !_showResult,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Result message
                  if (_showResult)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _isCorrect ? Colors.green.shade100 : Colors.red.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _isCorrect ? Colors.green : Colors.red,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _isCorrect ? Icons.check_circle : Icons.cancel,
                            color: _isCorrect ? Colors.green : Colors.red,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _isCorrect
                                  ? "Correct! It's a ${currentQuestion.correctAnswer}."
                                  : "Not quite. It's a ${currentQuestion.correctAnswer}.",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _isCorrect ? Colors.green.shade800 : Colors.red.shade800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  // Hint
                  if (!_showResult && !_showHint)
                    TextButton.icon(
                      onPressed: _showHintMessage,
                      icon: const Icon(Icons.lightbulb_outline),
                      label: const Text('Need a hint?'),
                    ),
                  
                  if (_showHint && !_showResult)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.amber,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.lightbulb,
                            color: Colors.amber,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              currentQuestion.hint,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber.shade800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _speakQuestion,
        backgroundColor: widget.quiz.color,
        child: const Icon(Icons.volume_up),
      ),
    );
  }
}

