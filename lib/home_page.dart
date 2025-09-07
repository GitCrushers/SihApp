import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gridly2/dashboard_page.dart';
import 'package:gridly2/team_page.dart';
import 'register_view.dart'; // your existing register page

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  bool get isLoggedIn => FirebaseAuth.instance.currentUser != null;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? user?.email ?? "Guest";

    final List<Widget> pages = isLoggedIn
        ? [
            buildWelcomeScreen(displayName), // index 0: Home content
            const TeamPage(), // index 1: Team
            const DashboardPage(), // index 2: Dashboard
            const SurveillancePage(), // index 3: Surveillance
            const NotificationsPage(), // index 4: Notifications
          ]
        : [
            buildWelcomeScreen(displayName), // Home only
            const TeamPage(),
          ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.grid_view, color: Colors.green),
            const SizedBox(width: 8),
            const Text("Gridly", style: TextStyle(fontWeight: FontWeight.bold)),
            const Spacer(),
            if (isLoggedIn)
              Text(
                displayName,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
          ],
        ),
        actions: [
          if (isLoggedIn)
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                setState(() {}); // refresh UI after logout
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: isLoggedIn
            ? const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.group), label: "Team"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: "Dashboard",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.videocam),
                  label: "Surveillance",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: "Notifications",
                ),
              ]
            : const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.group), label: "Team"),
              ],
      ),
    );
  }

  // 🔑 Welcome screen UI inside HomePage
  Widget buildWelcomeScreen(String displayName) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Hola $displayName!",
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "A powerful engagement tool that's intuitive\nand indispensable for clarity.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),

          // 🔑 Dynamic button
          ElevatedButton(
            onPressed: () {
              if (isLoggedIn) {
                // Switch to Dashboard tab
                setState(() {
                  _selectedIndex = 2;
                });
              } else {
                // Go to Register page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: Text(isLoggedIn ? "View Dashboard" : "Get Started"),
          ),
        ],
      ),
    );
  }
}
