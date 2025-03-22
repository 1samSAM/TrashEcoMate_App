import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final DatabaseReference _notificationsRef = FirebaseDatabase.instance.ref('notifications');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications'), centerTitle: true),
      body: StreamBuilder<DatabaseEvent>(
        stream: _notificationsRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return const Center(child: Text("No notifications yet"));
          }

          Map<dynamic, dynamic> data = (snapshot.data!.snapshot.value as Map<dynamic, dynamic>?) ?? {};
          List<Map<String, dynamic>> notifications = data.entries.map((entry) {
            return {
              'title': entry.value['title'] ?? 'No Title',
              'message': entry.value['message'] ?? 'No Message',
              'timestamp': entry.value['timestamp'] ?? 0,
            };
          }).toList();

          notifications.sort((a, b) => (b['timestamp']).compareTo(a['timestamp']));

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return NotificationTile(
                title: notifications[index]['title'],
                message: notifications[index]['message'],
                time: _formatTimestamp(notifications[index]['timestamp']),
              );
            },
          );
        },
      ),
    );
  }

  String _formatTimestamp(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return "${dateTime.hour}:${dateTime.minute}, ${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final String message;
  final String time;

  const NotificationTile({Key? key, required this.title, required this.message, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.notifications, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(message),
        trailing: Text(time, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
