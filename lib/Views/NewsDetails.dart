// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:news_app/Model/NewsModel.dart';
import 'package:news_app/Utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({super.key, required this.result});
  final Results result;

  @override
  Widget build(BuildContext context) {
    final format = new DateFormat('MMMM dd,yyyy');

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    DateTime dateTime = DateTime.parse(result.publishedDate.toString());
    Future<void> launchUrl(String url) async {
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
    }

    return Scaffold(
      
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        
        title: Center(child: Text(result.itemType.toString())),
        backgroundColor: kPrimaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {

                },
            icon: Icon(Icons.save_alt), ),
            
          )
          
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: screenWidth * 1.0,
                  height: screenHeight * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(
                          result!.multimedia!.first.url.toString()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Text(
                        result.title.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  result.subsection.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 120, 118, 118),
                  ),
                ),
                Text(
                  '${format.format(dateTime)},  ${result.itemType.toString()}',
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 120, 118, 118),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              result.abstract.toString(),
              style: TextStyle(
                  fontSize: 18, color: Colors.black, ),
            ),
          ),
            Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                launchUrl(result.url!);
              },
              child: Text(
                'View more...',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              '"Author:"' + result.byline.toString(),
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        
        ],
      ),
    );
  }
}
