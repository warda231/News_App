// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:news_app/Utils/colors.dart';
import 'package:news_app/Widgets/ProfileCard.dart';
import 'package:news_app/Widgets/ProfileInfoCount.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
       appBar: AppBar(
      backgroundColor: kPrimaryColor,
      title: Center(
        child: Text(
          'Profile ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: kSecondaryColor,
          ),
        ),
      ),
      actions: [
     
      ],
    ),
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      'https://pbs.twimg.com/media/FjU2lkcWYAgNG6d.jpg'),
                ),
                Positioned(
                  right: 0,
                  bottom: 2.0,
                  child: GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text('username'),
            Text('email'),
            SizedBox(height: 20),
            Container(
              width: screenWidth*0.8,
              height: screenHeight*0.09,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 234, 230, 230),
                borderRadius: BorderRadius.circular(10),
                
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
      
                  ProfileInfoCounts(screenWidth: screenWidth, screenHeight: screenHeight,
                  txt: 'Liked News',
                  count: '1,490',
                  ),
                  ProfileInfoCounts(screenWidth: screenWidth, screenHeight: screenHeight,
                  txt: 'Saved News',
                  count: '14',
                  ),
                  ProfileInfoCounts(screenWidth: screenWidth, screenHeight: screenHeight,
                  txt: 'Following ',
                  count: '190',
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            ProfileCardContainer(icon: Icons.person,txt: 'Edit Profile',
            onTap: (){},),
             ProfileCardContainer(icon: Icons.save_alt,txt: 'Saved News',
            onTap: (){},),
            ProfileCardContainer(icon: Icons.settings,txt: 'Settings',
            onTap: (){},),
             ProfileCardContainer(icon: Icons.logout,txt: 'Logout',
            onTap: (){},),
          ],
        ),
      ),
    );
  }
}




