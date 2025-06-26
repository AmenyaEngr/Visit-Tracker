import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../dimens/dimens.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                extraLargeVerticalSpacing,
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  width: 100,
                  height: 100,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/user.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                smallVerticalSpacing,
                Text('John doe', style: AppTextStyles.largeSubHeaderStyle),
                smallVerticalSpacing,
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('abc@gmail.com'),
                ),
                mediumVerticalSpacing,
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      _buildProfileItems(Icons.settings, 'Settings'),
                      _buildProfileItems(
                        Icons.group_add_outlined,
                        'Invite friend',
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            controller.signOut();
                          },
                          child: Row(
                            children: [
                              Icon(Icons.logout, color: Colors.red.shade500),
                              smallHorizontalSpacing,
                              Text(
                                "Log out",
                                style: TextStyle(
                                  color: Colors.red.shade500,
                                  fontSize: normalSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildProfileItems(IconData icon, String desc) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Icon(icon),
          smallHorizontalSpacing,
          Text(desc, style: AppTextStyles.subHeaderStyle),
        ],
      ),
    );
  }
}
