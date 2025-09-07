import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Dashboard Page (no bottom nav here!)
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dashboard Overview",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Card(
            child: ListTile(
              title: Text("Overview"),
              subtitle: Text("Data will go here"),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Card(
                  child: ListTile(
                    title: Text("Activity"),
                    subtitle: Text("Data later"),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: ListTile(
                    title: Text("Weather"),
                    subtitle: Text("Data later"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
