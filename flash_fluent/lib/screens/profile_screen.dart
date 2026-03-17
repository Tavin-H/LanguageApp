import 'package:flash_fluent/utils/app_consts.dart';
import 'package:flash_fluent/utils/user_save.dart';
import 'package:flutter/material.dart';
import 'package:flash_fluent/custom-widgets/navbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserSaveSerice _saveService = UserSaveSerice.instance;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundColor: AppColours.orange,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: AppColours.background,
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(40),
                            child: SizedBox(
                              height: 80,
                              child: Image.asset("assets/images/profile.jpg"),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Tavin Hartwood",
                        style: TextStyle(
                          color: AppColours.foreground,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFcf3e43),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                    onPressed: () {
                      _saveService.purgeData();
                    },
                    label: Text(
                      "Purge Data",
                      style: TextStyle(color: AppColours.background),
                    ),
                    icon: Icon(
                      Icons.delete_rounded,
                      color: AppColours.background,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            Navbar(),
          ],
        ),
      ),
    );
  }
}
