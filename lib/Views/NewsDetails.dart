// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/Model/NewsModel.dart';
import 'package:news_app/Model/SearchNewsModel.dart';
import 'package:news_app/Utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({Key? key, this.result, this.docsResult}) : super(key: key);

  final Results? result;
  final Docs? docsResult;
  Future<List<String>> getSavedNews() async {
  final prefs = await SharedPreferences.getInstance();
  List<String> savedNewsItems = prefs.getStringList('savedkey') ?? [];
  return savedNewsItems;
}

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('MMMM dd,yyyy');
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    DateTime? dateTime;
    List<String> multimediaUrls=[];
    String? title;
    String? itemType;
    String? subsection;
    String? abstract;
    String? url;
    String? byline;
        String? imgurl;



    if (result != null) {
      dateTime = DateTime.parse(result!.publishedDate.toString());
      multimediaUrls = result!.multimedia?.map((media) => media.url ?? '').toList() ?? [];
      title = result!.title;
      itemType = result!.itemType.toString();
      subsection = result!.subsection;
      abstract = result!.abstract;
      url = result!.url;
      byline = result!.byline;
      imgurl=result!.multimedia!.first.url;
    } else if (docsResult != null) {
      dateTime = DateTime.parse(docsResult!.pubDate.toString());
      multimediaUrls = docsResult!.multimedia?.map((media) => media.url ?? '').toList() ?? [];
      title = docsResult!.headline?.main; // Corrected access to headline
      itemType = docsResult!.documentType.toString();
      subsection = docsResult!.subsectionName;
      abstract = docsResult!.abstract;
      url = docsResult!.webUrl;
            imgurl=docsResult!.multimedia!.first.url;

      byline = docsResult!.byline?.toString(); // Corrected access to byline
    }

  Future<void> saveNews() async {
  final prefs = await SharedPreferences.getInstance();
  List<String> savedNewsItems = prefs.getStringList('savedkey') ?? [];

  Map<String, dynamic> uiDetails = {
    'title': title,
    'itemType': itemType,
    'subsection': subsection,
    'abstract': abstract,
    'url': imgurl,
    'byline': byline,
          'weburl':url,

  };

  savedNewsItems.add(json.encode(uiDetails));

  await prefs.setStringList('savedkey', savedNewsItems);
}



    Future<void> launchUrl(String url) async {
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
    }

    final PageController _pageController = PageController();

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: Center(child: Text(itemType ?? '')), // Handle nullability
        backgroundColor: kPrimaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                saveNews();
              },
              icon: const Icon(Icons.save_alt),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: screenHeight*0.4,
                child: PageView.builder(
                          itemCount: multimediaUrls.length,
              controller: _pageController,
                  itemBuilder: (context,index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: screenWidth * 1.0,
                        height: screenHeight * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                      image: NetworkImage(multimediaUrls[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(20),
                        bottomRight: const Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      title ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
               Positioned(
                left: 0,
                top: screenHeight * 0.1,
                bottom: screenHeight * 0.1,
                child: IconButton(
                  onPressed: () {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: Icon(Icons.arrow_back),
                  color: Color.fromARGB(255, 194, 191, 191),
                  iconSize: 30,
                ),
              ),
              Positioned(
                right: 0,
                
                top: screenHeight * 0.1,
                bottom: screenHeight * 0.1,
                child: IconButton(
                  onPressed: () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: Icon(Icons.arrow_forward),
                  color: Color.fromARGB(255, 194, 191, 191),
                  iconSize: 30,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  subsection ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 120, 118, 118),
                  ),
                ),
                Text(
                  '${format.format(dateTime ?? DateTime.now())},  ${itemType ?? ''}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 120, 118, 118),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              abstract ?? '',
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                launchUrl(url ?? '');
              },
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
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              '"Author:"' + (byline ?? ''),
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

