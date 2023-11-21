// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Repository/NewsRepository.dart';
import 'package:news_app/Utils/colors.dart';
import 'package:news_app/Views/NewsDetails.dart';
import 'package:news_app/Views/SearchDetails.dart';
import 'package:news_app/Widgets/SearchBar.dart';

import '../Model/NewsModel.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late String selectedCategory = "All";
  final rep = NewRepository();

  int selectedCategoryIndex = 0;
  List<String> categorylist = ['All', 'Sports', 'Arts', 'Business', 'Politics'];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    TextEditingController searchController = TextEditingController();

    String formattedDate(String dateStr) {
      DateTime dateTime = DateTime.parse(dateStr);

      String formatted = DateFormat('MMM,d').format(dateTime);

      return formatted;
    }

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Searchbar(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            searchController: searchController,
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Search(),
                ),
              );
            },
            onChanged: (query) {},
            onSearchPressed: () {},
          ),
          Container(
            height: screenHeight * 0.09,
            width: screenWidth * 0.8,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categorylist.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategoryIndex = index;
                          selectedCategory = categorylist[index].toString();
                        });
                      },
                      child: Container(
                        height: screenHeight * 0.08,
                        width: screenWidth * 0.26,
                        decoration: BoxDecoration(
                          color: selectedCategoryIndex == index
                              ? kSecondaryColor
                              : const Color.fromARGB(255, 203, 199, 199),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Text(
                          categorylist[index],
                          style: TextStyle(
                            color: selectedCategoryIndex == index
                                ? Colors.white
                                : Colors.black,
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
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FutureBuilder(
                      future: rep.fetch(selectedCategory),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
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
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      width: screenWidth * 1.0,
                                                      height:
                                                          screenHeight * 0.18,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                            result!.multimedia !=
                                                                        null &&
                                                                    result
                                                                        .multimedia!
                                                                        .isNotEmpty
                                                                ? result
                                                                    .multimedia!
                                                                    .first!
                                                                    .url!
                                                                : '',
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      alignment:
                                                          Alignment.center,
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            result!.title !=
                                                                    null
                                                                ? result.title
                                                                    .toString()
                                                                : 'Default Subsection',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                                  result!.subsection !=
                                                                          null
                                                                      ? result
                                                                          .subsection
                                                                          .toString()
                                                                      : 'Default Subsection',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    //fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  formattedDate(result!
                                                                              .publishedDate !=
                                                                          null
                                                                      ? result
                                                                          .publishedDate
                                                                          .toString()
                                                                      : DateTime
                                                                              .now()
                                                                          .toString()),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        13,
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
    );
  }
}
