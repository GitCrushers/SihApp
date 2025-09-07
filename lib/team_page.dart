import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gridly2/home_page.dart';

// Team Page
class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final members = [
      {"name": "Ava Reed", "initials": "AR"},
      {"name": "Noah Chen", "initials": "NC"},
      {"name": "Mia Patel", "initials": "MP"},
      {"name": "Leo Park", "initials": "LP"},
      {"name": "Zoe Kim", "initials": "ZK"},
      {"name": "Omar Ali", "initials": "OA"},
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Team",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              itemCount: members.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final member = members[index];
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.green.shade100,
                      child: Text(
                        member["initials"]!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      member["name"]!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Member",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SurveillancePage extends StatelessWidget {
  const SurveillancePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Surveillance Page"));
  }
}

// Notifications Page
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Notifications Page"));
  }
}
