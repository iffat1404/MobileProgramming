import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../theme/app_theme.dart';
import 'tabs/faculty_tab.dart';
import 'tabs/vision_mission_tab.dart';
import 'tabs/notification_tab.dart';
import 'tabs/webview_tab.dart';
import 'tabs/feedback_tab.dart';
class HomeScreen extends StatefulWidget {
  static final GlobalKey<_HomeScreenState> homeScreenKey = GlobalKey<_HomeScreenState>();

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  void switchTab(int index) {
    _tabController.animateTo(index);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('MCA Department'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppTheme.accentColor,
          indicatorColor: AppTheme.accentColor,
          tabs: const [
            Tab(text: 'Faculty', icon: Icon(Icons.people)),
            Tab(text: 'Vision & Mission', icon: Icon(Icons.visibility)),
            Tab(text: 'Notifications', icon: Icon(Icons.notifications)),
            Tab(text: 'Website', icon: Icon(Icons.web)),
            Tab(text: 'Feedback', icon: Icon(Icons.feedback)),
          ],
        ),
      ),
      drawer:  AppDrawer(tabController: _tabController),
      body: TabBarView(
        controller: _tabController,
        children: const [
          FacultyTab(),
          VisionMissionTab(),
          NotificationsTab(),
          WebViewTab(),
          FeedbackTab(),
        ],
      ),
    );
  }
}

