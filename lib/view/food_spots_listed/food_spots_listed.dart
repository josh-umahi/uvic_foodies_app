import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubits/food_spot_thumbnail_cubit.dart';
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
      backgroundColor: Color(0xFFF5F5F5),
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
                SizedBoxes.vertical1,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SearchBar(),
                ),
                SizedBoxes.vertical1,
                FilterButtonBar(),
                SizedBoxes.vertical1,
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
                  child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                      children: [
                        SizedBoxes.vertical1,
                        ...state.foodSpotThumbnails.map((foodSpotThumbnail) =>
                            FoodSpotCard(foodSpotThumbnail)),
                        SizedBox(height: 40),
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
