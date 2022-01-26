import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubits/food_spot_thumbnails_cubit.dart';
import '../constants.dart';
import '../food_spots_listed/widgets/filter_button_bar.dart';
import '../food_spots_listed/widgets/search_bar.dart';
import 'widgets/food_spot_card.dart';

class FoodSpotsListedScreen extends StatefulWidget {
  const FoodSpotsListedScreen({Key? key}) : super(key: key);

  @override
  _FoodSpotsListedScreenState createState() => _FoodSpotsListedScreenState();
}

class _FoodSpotsListedScreenState extends State<FoodSpotsListedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 15),
                SafeArea(
                  bottom: false,
                  child: ourLogo,
                ),
                const SizedBox(height: 13),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SearchBar(),
                ),
                // const FilterButtonBar(),
                // TODO: Test out using hero animation, yes open it up in new page!
                const SizedBox(height: 13),
                const Divider(
                  color: ColorConstants.lightGrey2,
                  thickness: 1,
                  height: 1,
                ),
              ],
            ),
          ),
          BlocBuilder<FoodSpotThumbnailsCubit, FoodSpotThumbnailsState>(
            builder: (_, state) {
              if (state is FoodSpotThumbnailsLoaded) {
                return Expanded(
                  // TODO Change to ListView.builder
                  child: ListView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
                      children: [
                        const SizedBox(height: 13),
                        ...state.foodSpotThumbnails.map((foodSpotThumbnail) =>
                            FoodSpotCard(foodSpotThumbnail)),
                      ]),
                );
              } else {
                return Container(
                  width: 200,
                  height: 200,
                  color: Colors.lightGreen,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
