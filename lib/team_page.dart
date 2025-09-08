import 'package:flutter/material.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  final List<Map<String, String>> members = const [
    {"name": "1", "role": "Member", "image": "assets/1.png"},
    {"name": "2", "role": "Member", "image": "assets/2.jpg"},
    {"name": "3", "role": "Member", "image": "assets/3.jpg"},
    {"name": "4", "role": "Member", "image": "assets/4.png"},
    {"name": "5", "role": "Member", "image": "assets/5.png"},
    {"name": "6", "role": "Member", "image": "assets/6.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Team",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          // 👇 ensures grid fills the remaining space above bottom nav
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 per row
              crossAxisSpacing: 20,
              mainAxisSpacing: 1,
              childAspectRatio: 1,
            ),
            itemCount: members.length,
            itemBuilder: (context, index) {
              final member = members[index];
              return Column(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage(member["image"]!),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    member["name"]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    member["role"]!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              );
            },
          ),
        ),
      ],
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
