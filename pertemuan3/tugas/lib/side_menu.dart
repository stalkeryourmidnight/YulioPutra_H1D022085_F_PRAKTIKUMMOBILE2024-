import 'package:flutter/material.dart';
import 'package:tugas/home_page.dart';
import 'package:tugas/about_page.dart';
import 'package:tugas/profile_page.dart';
import 'package:tugas/settings_page.dart';
import 'package:tugas/contact_us_page.dart';

class Sidemenu extends StatelessWidget {
  const Sidemenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // Shadow position
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image.asset("assets/yulio.jpg", fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Yulio",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "bismillah orang kaya",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.home_outlined, color: Colors.blueAccent),
                  title: const Text(
                    'Home',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.info_outline, color: Colors.deepPurple),
                  title: const Text(
                    'About',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutPage()),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.person_outline, color: Colors.orange),
                  title: const Text(
                    'Profile',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfilePage()),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.settings_outlined, color: Colors.green),
                  title: const Text(
                    'Settings',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsPage()),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.contact_mail_outlined, color: Colors.red),
                  title: const Text(
                    'Contact Us',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ContactUsPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // Add your logout functionality here
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
