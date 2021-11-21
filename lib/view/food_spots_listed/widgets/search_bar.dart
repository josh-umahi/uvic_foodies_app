import 'dart:ui';

import 'package:flutter/material.dart';

import '../../constants.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: ColorConstants.lightGrey1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            size: 20,
            color: ColorConstants.darkGrey1,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              alignment: Alignment.center,
              child: const TextField(
                keyboardType: TextInputType.text,
                cursorColor: ColorConstants.darkGrey1,
                cursorHeight: 15,
                style: TextStyle(
                  fontFamily: "Avenir",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 13.3),
                  fillColor: Colors.red,
                  hintText: "Search food services",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
