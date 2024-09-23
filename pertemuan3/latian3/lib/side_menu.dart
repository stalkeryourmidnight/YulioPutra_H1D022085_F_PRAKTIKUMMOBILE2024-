import 'package:flutter/material.dart';
import 'package:latian3/home_page.dart';
import 'package:latian3/about_page.dart';  // Import this if you haven't already

class Sidemenu extends StatelessWidget {
  const Sidemenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text('Sidemenu'),
          ),
          ListTile(
            leading: const Icon(Icons.home),  // Fix the icon here
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutPage(),  // Ensure you have AboutPage
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
