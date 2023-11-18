import 'package:flutter/material.dart';
import 'package:news_app/Utils/colors.dart';

class ProfileCardContainer extends StatelessWidget {
  const ProfileCardContainer({

    super.key, required this.icon, required this.txt, required this.onTap,
  });

  final IconData icon;
  final String txt;
    final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        shadowColor: const Color.fromARGB(255, 230, 229, 229),
    
        child: ListTile(
          leading: Icon(icon,color: kSecondaryColor,),
          title: Text(txt,style: TextStyle(
            color: Colors.black
          ),),
          onTap: onTap,
        ),
      ),
    );
  }
}