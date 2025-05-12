import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../screens/tabs/faculty_tab.dart';
import '../screens/tabs/vision_mission_tab.dart';
import '../screens/tabs/notification_tab.dart';
import '../screens/tabs/webview_tab.dart';
import '../screens/tabs/feedback_tab.dart';
class AppDrawer extends StatelessWidget {
  final TabController tabController;

  const AppDrawer({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 67, 16, 82),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 80,
                ),
                const SizedBox(height: 12),
                const Text(
                  'MCA Department',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.people,
            title: 'Faculty',
            onTap: () => _navigateToTab(context, 0),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.visibility,
            title: 'Vision & Mission',
            onTap: () => _navigateToTab(context, 1),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.notifications,
            title: 'Notifications',
            onTap: () => _navigateToTab(context, 2),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.web,
            title: 'Website',
            onTap: () => _navigateToTab(context, 3),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.feedback,
            title: 'Feedback',
            onTap: () => _navigateToTab(context, 4),
          ),
          const Divider(),
          _buildDrawerItem(
            context,
            icon: Icons.info,
            title: 'About',
            onTap: () {
              Navigator.pop(context);
              _showAboutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Color.fromARGB(255, 67, 16, 82)),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  void _navigateToTab(BuildContext context, int index) {
    Navigator.pop(context);
    tabController.animateTo(index);
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About MCA Department App'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This app provides information about the MCA Department at Sardar Patel Institute of Technology.',
            ),
            SizedBox(height: 16),
            Text(
              'Version 1.0.0',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
