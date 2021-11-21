import 'package:flutter/material.dart';

import '../../../data/models/enums.dart';
import '../../constants.dart';
import '../../global_widgets/custom_texts.dart';

class SeeTodaysMenu extends StatelessWidget {
  /// We only show the "SEE TODAY'S MENU" button when the foodSpot has its mealOfferings
  /// in a URL format and the availabilityStatus is OpenNow or ReOpensLaterToday because
  /// these are the two scenarios where we're sure you want to see this. We don't show this
  /// during overrides because the override reason could be "Closed for ..." and so people'll get confused
  const SeeTodaysMenu({
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
      final color = chooseColor(availabilityStatus);

      return GestureDetector(
        child: Container(
          margin: const EdgeInsets.only(top: 14),
          padding: EdgeInsets.symmetric(vertical: verticalSpacing),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 0.5,
                color: color,
              ),
            ),
          ),
          alignment: Alignment.center,
          child: PrimaryText(
            "SEE TODAY'S MENU",
            fontSize: 15,
            color: color,
            fontWeight: FontWeight.w500,
            lineHeight: 1.3,
            letterSpacing: 0.75,
          ),
        ),
      );
    } else {
      return SizedBox(height: verticalSpacing);
    }
  }

  Color chooseColor(AvailabilityStatus? availabilityStatus) {
    assert(availabilityStatus == AvailabilityStatus.OpenNow ||
        availabilityStatus == AvailabilityStatus.ReOpensLaterToday);

    if (availabilityStatus == AvailabilityStatus.OpenNow) {
      return ColorConstants.green1;
    } else {
      return ColorConstants.yellow1;
    }
  }
}
