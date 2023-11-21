import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Model/NewsModel.dart';
import 'package:news_app/Repository/NewsRepository.dart';
import 'package:news_app/Views/NewsDetails.dart';
import 'package:news_app/Widgets/SearchBar.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late String selectedCategory = "All";
  final rep = NewRepository();
  String? searchQuery;

  bool check = false;

  void search(String query) {
    setState(() {
      searchQuery = query;
      check = true;
      print(check);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    TextEditingController searchController = TextEditingController();
    Timer? _debounce;

    String formattedDate(String dateStr) {
      DateTime dateTime = DateTime.parse(dateStr);

      String formatted = DateFormat('MMM,d').format(dateTime);

      return formatted;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                Expanded(
                  child: Searchbar(
                    screenWidth: screenWidth,
                    ontap: () {},
                    screenHeight: screenHeight,
                    searchController: searchController,
                    onChanged: (query) {
                      if (_debounce?.isActive ?? false) _debounce!.cancel();
                      _debounce = Timer(const Duration(milliseconds: 1000), () {
                        print('Filtered news count: ${searchController.text}');
                      });
                    },
                    onSearchPressed: () {
                      final query = searchController.text;
                      search(query);
                      setState(() {
                        check = true;
                        print('Check set to true: $check');
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            if (check)
              FutureBuilder(
                  future: rep.fetchNewsCategoryApi(searchQuery ?? ''),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print('Data: ${snapshot.data}');

                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      if (snapshot.error is ApiException) {
                        // Access the message property of ApiException
                        return Container(
                          padding: EdgeInsets.all(16),
                          alignment: Alignment.center,
                          child: Text(
                            (snapshot.error as ApiException).message,
                            style: TextStyle(color: Colors.green),
                          ),
                        );
                      } else {
                        return Container(
                          padding: EdgeInsets.all(16),
                          alignment: Alignment.center,
                          child: Text(
                            'An unexpected error occurred.',
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      }
                    } else if (!snapshot.hasData) {
                      return Text('No data available');
                    } else {
                      final newsData = snapshot.data;

                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: newsData?.response!.docs!.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final result = newsData?.response!.docs![index];
                            //final newsUrl = result!.webUrl!;

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
                                          NewsDetails(docsResult: result),
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
                                                      image: result?.multimedia !=
                                                                  null &&
                                                              result!
                                                                  .multimedia!
                                                                  .isNotEmpty &&
                                                              result!
                                                                      .multimedia!
                                                                      .first!
                                                                      .url !=
                                                                  null
                                                          ? NetworkImage(
                                                              result!
                                                                  .multimedia!
                                                                  .first!
                                                                  .url!
                                                                  .toString(),
                                                            )
                                                          : NetworkImage(''),
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
                                                        result!.headline
                                                                    ?.main !=
                                                                null
                                                            ? result!
                                                                .headline!.main!
                                                                .toString()
                                                            : 'No headline exists',
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
                                                              result!.printSection !=
                                                                      null
                                                                  ? result!
                                                                      .printSection!
                                                                      .toString()
                                                                  : ' ',
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                //fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              formattedDate(
                                                                result!.pubDate !=
                                                                        null
                                                                    ? result!
                                                                        .pubDate
                                                                        .toString()
                                                                    : DateTime
                                                                            .now()
                                                                        .toString(),
                                                              ),
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
                  })
          ],
        ),
      ),
    );
  }
}
