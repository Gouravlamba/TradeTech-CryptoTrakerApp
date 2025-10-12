import 'dart:io';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Gourav Kumar";
  String email = "gouravlamba91@gmail.com";
  String holding = "My Trading";
  String portfolio = "My Portfolio";
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4.3,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primary.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 105.0),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -60,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Material(
                      elevation: 6,
                      shape: const CircleBorder(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: selectedImage == null
                            ? Image.asset(
                                "assets/image2.jpg",
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                selectedImage!,
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),

            // Info Cards
            infoCard(Icons.person, "Name", name, isDark),
            const SizedBox(height: 15),
            infoCard(Icons.email, "Email", email, isDark),
            const SizedBox(height: 15),
            infoCard(Icons.trending_up, "My Holdings", holding, isDark),
            const SizedBox(height: 15),
            infoCard(Icons.pie_chart, "portfolio", portfolio, isDark),

            const SizedBox(height: 15),

            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: theme.colorScheme.primary,
                ),
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  "Logout",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoCard(IconData icon, String label, String value, bool isDark) {
    return Container(
      height: 62,
      margin: const EdgeInsets.only(left: 40, right: 40),
      child: Material(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Row(
            children: [
              Icon(icon, color: isDark ? Colors.white : Colors.black),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                          color: isDark ? Colors.white70 : Colors.black54,
                          fontSize: 10)),
                  Text(value,
                      style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
