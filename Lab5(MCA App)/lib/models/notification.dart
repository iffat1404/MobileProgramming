import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String description;
  final String date;
  final String link;
  final NotificationType type;
  final bool isUrgent;

  NotificationItem({
    required this.title,
    required this.description,
    required this.date,
    this.link = '',
    this.type = NotificationType.general,
    this.isUrgent = false,
  });

  IconData getIcon() {
    switch (type) {
      case NotificationType.event:
        return Icons.event;
      case NotificationType.academic:
        return Icons.school;
      case NotificationType.placement:
        return Icons.work;
      case NotificationType.general:
      default:
        return Icons.notifications;
    }
  }
}

enum NotificationType {
  general,
  event,
  academic,
  placement,
}

final List<NotificationItem> notificationsList = [
  NotificationItem(
    title: 'MCA Admissions 2023-24',
    description: 'Applications are now open for MCA admissions for the academic year 2023-24. Last date to apply is June 30, 2023.',
    date: 'May 15, 2023',
    link: 'https://mca.spit.ac.in/admissions',
    type: NotificationType.academic,
    isUrgent: true,
  ),
  NotificationItem(
    title: 'Tech Symposium 2023',
    description: 'Annual technical symposium featuring workshops, hackathons, and guest lectures from industry experts.',
    date: 'April 10, 2023',
    link: 'https://mca.spit.ac.in/events/techsymposium2023',
    type: NotificationType.event,
  ),
  NotificationItem(
    title: 'Campus Placement Drive',
    description: 'Major IT companies will be visiting campus for recruitment. Eligible students must register by May 5, 2023.',
    date: 'April 25, 2023',
    link: 'https://mca.spit.ac.in/placements',
    type: NotificationType.placement,
    isUrgent: true,
  ),
  NotificationItem(
    title: 'Workshop on Cloud Computing',
    description: 'Two-day workshop on AWS and Azure cloud services. Certificates will be provided to all participants.',
    date: 'March 18, 2023',
    link: 'https://mca.spit.ac.in/workshops',
    type: NotificationType.event,
  ),
  NotificationItem(
    title: 'Semester Exam Schedule',
    description: 'The end semester examination for MCA will commence from June 10, 2023. Detailed schedule is now available.',
    date: 'March 5, 2023',
    link: 'https://mca.spit.ac.in/examinations',
    type: NotificationType.academic,
  ),
  NotificationItem(
    title: 'Alumni Meet 2023',
    description: 'Annual alumni gathering will be held on July 15, 2023. All alumni are cordially invited to attend.',
    date: 'February 28, 2023',
    link: 'https://mca.spit.ac.in/alumni',
    type: NotificationType.event,
  ),
];