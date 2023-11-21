// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Model/SavedNewsModel.dart';
import 'package:news_app/Utils/colors.dart';
import 'package:news_app/Views/NewsDetails.dart';
import 'package:url_launcher/url_launcher.dart';

class SavedNewsScreen extends StatefulWidget {
  const SavedNewsScreen({super.key});

  @override
  State<SavedNewsScreen> createState() => _SavedNewsScreenState();
}

class _SavedNewsScreenState extends State<SavedNewsScreen> {
  NewsDetails obj = NewsDetails();

late List<String> savedNews = [];
  @override
  void initState() {
    super.initState();
    _loadSavedNews();
  }
  List<SavedNewsItem> savedItems = [];

 Future<void> _loadSavedNews() async {
  List<String> news = await obj.getSavedNews();
  print('Retrieved news: $news');


  for (String itemJson in news) {
    try {
      Map<String, dynamic> jsonMap = json.decode(itemJson);
      SavedNewsItem savedItem = SavedNewsItem.fromJson(jsonMap);
      savedItems.add(savedItem);
    } catch (e) {
      print('Error decoding JSON: $itemJson');
      print('Error details: $e');
    }
  }
  setState(() {});

}



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
        final format = DateFormat('MMMM dd,yyyy');


Future<void> launchUrl(String url) async {
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Center(
          child: Text('Saved News Articles',style: TextStyle(
            fontWeight: FontWeight.bold,
          ),),
        ),
      ),
      body:
      
       ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: savedItems.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final savedItemJson = savedItems[index];
      
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          width: screenWidth * 3.0,
                          height: screenHeight * 0.27,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 198, 195, 195),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: screenWidth * 1.0,
                                    height: screenHeight * 0.18,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(savedItemJson.url.toString()),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Flexible(
                                child: Container(
                                  width: screenWidth * 0.9,
                                  height: screenHeight * 0.8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          savedItemJson.title,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                savedItemJson.subsection,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  //fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                              // '${format.format( savedItemJson.pubdate as DateTime)} '
                                               '',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            
                             Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                launchUrl(savedItemJson.weburl ?? '');
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'View more...',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              })
    );
  }
}
