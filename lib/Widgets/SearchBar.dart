import 'package:flutter/material.dart';
import 'package:news_app/Utils/colors.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.searchController,
    required this.onChanged,
    required this.onSearchPressed, required this.ontap, // Add the onSearchPressed callback
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final TextEditingController searchController;
  final ValueChanged<String> onChanged;
  final VoidCallback onSearchPressed;
    final VoidCallback ontap; 

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: screenWidth * 0.88,
          height: screenHeight * 0.07,
          child: TextField(
            onChanged: onChanged,
            controller: searchController,
            onTap: ontap,
            decoration: InputDecoration(
              filled: true,
              fillColor: kSecondaryColor,
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  color: kPrimaryColor,
                ),
                onPressed: onSearchPressed, // Trigger search when pressed
              ),
              hintText: 'Search...',
              hintStyle: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontStyle: FontStyle.normal,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
