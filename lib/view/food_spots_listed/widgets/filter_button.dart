import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/cubits/food_spot_thumbnails_cubit.dart';
import '../../../logic/cubits/overriden_date_cubit.dart';
import '../../constants.dart';
import '../../global_widgets/custom_texts.dart';
import '../constants.dart/enums.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    Key? key,
    required this.label,
    required this.filterType,
    required this.selectedLabel,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final FilterType filterType;
  final String selectedLabel;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: ElevatedButton(
        onPressed: () {
          onTap(label);
          performFilter(context);
        },
        style: ElevatedButton.styleFrom(
          primary: selectedLabel == label
              ? ColorConstants.darkGrey2
              : ColorConstants.lightGrey1,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          elevation: 0,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: ColorConstants.darkGrey2,
              width: 0.5,
            ),
          ),
        ),
        child: PrimaryText(
          label,
          fontSize: 14,
          color:
              selectedLabel == label ? Colors.white : ColorConstants.darkGrey2,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void performFilter(BuildContext context) {
    switch (filterType) {
      case FilterType.OpenNow:
        return context.read<FoodSpotThumbnailsCubit>().filterByOpenNow(
              context.read<OverridenDateCubit>(),
            );
      case FilterType.TheSub:
        return context.read<FoodSpotThumbnailsCubit>().filterByTheSub();
      case FilterType.MysticMarket:
        return context.read<FoodSpotThumbnailsCubit>().filterByMysticMarket();
      case FilterType.TheMod:
        return context.read<FoodSpotThumbnailsCubit>().filterByTheMod();
      default:
        // TODO: Replace assertion, observe that there's no try catch here
        assert(filterType == FilterType.All);
        return context.read<FoodSpotThumbnailsCubit>().filterByAll();
    }
  }
}
