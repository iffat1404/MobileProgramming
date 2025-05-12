import 'package:flutter/material.dart';
import 'tabs/lessons_tab.dart';
import 'tabs/quiz_tab.dart';
import 'tabs/leaderboard_tab.dart';
import 'tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Color _getAppBarColor(int index) {
    // Tab 0 is blue, others are white
    return Colors.blue;
  }

  Color _getTextColor(int index) {
    return Colors.white;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {}); // Rebuild AppBar when tab changes
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBarColor = _getAppBarColor(_tabController.index);
    final textColor = _getTextColor(_tabController.index);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kids Learning App',
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ),
        backgroundColor: appBarColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: textColor,
          indicatorWeight: 4,
          labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          labelColor: textColor,
          unselectedLabelColor: textColor.withOpacity(0.6),
          tabs: const [
            Tab(icon: Icon(Icons.book), text: 'Lessons'),
            Tab(icon: Icon(Icons.quiz), text: 'Quiz'),
            Tab(icon: Icon(Icons.leaderboard), text: 'Leaders'),
            Tab(icon: Icon(Icons.person), text: 'Profile'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          LessonsTab(),
          QuizTab(),
          LeaderboardTab(),
          ProfileTab(),
        ],
      ),
    );
  }
}
