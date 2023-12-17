import 'package:flutter/material.dart';
import 'login.dart'; // Import file login.dart atau sesuaikan dengan file login Anda

class Profile extends StatelessWidget {
  final int selectedIndex;

  Profile({required this.selectedIndex});
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout Confirmation"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Perform logout and navigate to the login page
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => login(), // Use the correct class name for your login page
                  ),
                );
              },
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Show the logout confirmation dialog directly
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _showLogoutDialog(context);
    });

    // Return an empty container as you don't want to display any UI in this case
    return Container();
  }
}
