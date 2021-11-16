import 'package:flutter/material.dart';

import '../../../data/models/enums.dart';
import '../../constants.dart';
import '../../global_widgets/custom_texts.dart';

class SeeTodaysMenu extends StatelessWidget {
  /// We only show the "SEE TODAY'S MENU" button when the foodSpot has its mealOfferings
  /// in a URL format and the availabilityStatus is OpenNow or ReOpensLaterToday because
  /// these are the two scenarios where we're sure you want to see this. We don't show this
  /// during overrides because the override reason could be "Closed for ..." and so people'll get confused
  ///
  // ignore: prefer_const_constructors_in_immutables
  SeeTodaysMenu({
    Key? key,
    required this.mealOfferingsUrl,
    required this.availabilityStatus,
    required this.verticalSpacing,
  }) : super(key: key);

  final String? mealOfferingsUrl;
  final AvailabilityStatus? availabilityStatus;
  final double verticalSpacing;

  @override
  Widget build(BuildContext context) {
    if (mealOfferingsUrl != null &&
        (availabilityStatus == AvailabilityStatus.OpenNow ||
            availabilityStatus == AvailabilityStatus.ReOpensLaterToday)) {
      return GestureDetector(
        child: Container(
          margin: EdgeInsets.only(top: 14),
          padding: EdgeInsets.symmetric(vertical: verticalSpacing),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 0.5,
                color: ColorConstants.blue1,
              ),
            ),
          ),
          alignment: Alignment.center,
          child: PrimaryText(
            "SEE TODAY'S MENU",
            fontSize: 15,
            color: ColorConstants.blue1,
            fontWeight: FontWeight.w400,
            lineHeight: 1.3,
            letterSpacing: 0.75,
          ),
        ),
      );
    } else {
      return SizedBox(height: verticalSpacing);
    }
  }
}
