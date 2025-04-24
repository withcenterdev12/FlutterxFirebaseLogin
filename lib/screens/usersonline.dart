import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class OnlineUsers extends StatelessWidget {
  static const routeName = '/onlineusers';
  const OnlineUsers({super.key});

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref("users");

    return Scaffold(
      appBar: AppBar(title: const Text('Online Users')),
      body: StreamBuilder<DatabaseEvent>(
        stream: ref.onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return const Center(child: Text('No users found.'));
          }

          final data = snapshot.data!.snapshot.value as Map;

          final users =
              data.entries.map((entry) {
                final userData = entry.value as Map;
                return {
                  'email': userData['email'] ?? 'N/A',
                  'status': userData['status'] ?? 'offline',
                };
              }).toList();

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final isOnline = user['status'] == 'online';

              return ListTile(
                leading: CircleAvatar(
                  radius: 8,
                  backgroundColor: isOnline ? Colors.green : Colors.grey,
                ),
                title: Text(user['email']),
              );
            },
          );
        },
      ),
    );
  }
}
