import 'package:flutter/material.dart';
import 'package:news_app/Utils/colors.dart';


class ProfileInfoCounts extends StatelessWidget {
  const ProfileInfoCounts({
    super.key,
    required this.screenWidth,
    required this.screenHeight, required this.txt, required this.count,
  });

  final double screenWidth;
  final double screenHeight;
  final String txt;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: screenWidth*0.19,
              height: screenHeight*0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
    
              ),
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
            children: [
              
               TextSpan(
                        text: '${count}\n',
                        
                        style: 
                        TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          
                        
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      TextSpan(
                        text: txt,
                        style: TextStyle(
                          fontSize: 10,
                          color: const Color.fromARGB(255, 127, 125, 125),
                        
                        ),
                      ),
            ]
          ),),
        ),
      ),
    );
  }
}