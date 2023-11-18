// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Repository/NewsRepository.dart';
import 'package:news_app/Utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Views/NewsDetails.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategoryIndex = 0;
  List<String> list = ['Feeds', 'Popular', 'Recent'];
  final rep = NewRepository();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    String formattedDate(String dateStr) {
      DateTime dateTime = DateTime.parse(dateStr);

      String formatted = DateFormat('MMM,d').format(dateTime);

      return formatted;
    }

    return Scaffold(
       appBar: AppBar(
      backgroundColor: kPrimaryColor,
      title: Center(
        child: Text(
          'News App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: kSecondaryColor,
          ),
        ),
      ),
      actions: [
        /*Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.dark_mode, color: Colors.black),
          ),
        )*/
      ],
    ),
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Welcome Back!',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontStyle: FontStyle.normal),
            ),
            Container(
              height: screenHeight * 0.09,
              width: screenWidth * 0.8,
              decoration: BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategoryIndex = index;
                            });
                          },
                          child: Container(
                            height: screenHeight * 0.08,
                            width: screenWidth * 0.2,
                            decoration: BoxDecoration(
                              color: selectedCategoryIndex == index
                                  ? Colors.white
                                  : kSecondaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text(
                              list[index],
                              style: TextStyle(
                                color: selectedCategoryIndex == index
                                    ? Colors.black
                                    : Colors.white,
                                fontWeight: selectedCategoryIndex == index
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                              ),
                            )),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Breaking News',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'See more',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FutureBuilder(
                        future: rep.fetchNewsApi(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            print('Error : ${snapshot.error}');
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData) {
                            return Text('No data available');
                          } else {
                            final newsData = snapshot.data;
              
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: newsData?.results?.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  final result = newsData?.results![index];
                                  final newsUrl = result!.url;
              
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 5,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                NewsDetails(result: result),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.symmetric(vertical: 10),
                                            child: Container(
                                              width: screenWidth * 3.0,
                                              height: screenHeight * 0.2,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                        255, 198, 195, 195),
                                                    spreadRadius: 3,
                                                    blurRadius: 10,
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                children: [
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(8.0),
                                                      child: Container(
                                                        width: screenWidth * 1.0,
                                                        height: screenHeight * 0.18,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10),
                                                          image: DecorationImage(
                                                            image: NetworkImage(
                                                                result!.multimedia!
                                                                    .first.url
                                                                    .toString()),
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
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              result.title.toString(),
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    result.subsection
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                      fontSize: 13,
                                                                      //fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    formattedDate(result
                                                                        .publishedDate
                                                                        .toString()),
                                                                    style: TextStyle(
                                                                      fontSize: 13,
                                                                      //fontWeight: FontWeight.bold,
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
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
