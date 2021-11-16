import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/enums.dart';
import '../../../data/models/food_spot/food_spot_thumbnail.dart';
import '../../../data/models/times_and_dates/overriden_date.dart';
import '../../../data/repositories/constants.dart';
import '../../../logic/cubits/overriden_date_cubit.dart';
import '../../global_widgets/custom_texts.dart';
import 'availability_status_icon.dart';
import 'see_todays_menu.dart';

const circularRadiusValue = 20.0;

class FoodSpotCard extends StatelessWidget {
  const FoodSpotCard(
    this.foodSpotThumbnail, {
    Key? key,
  }) : super(key: key);

  final FoodSpotThumbnail foodSpotThumbnail;

  static const double _horizontalSpacing = 16;
  static const double _verticalSpacing = 12;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(circularRadiusValue),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 1),
              blurRadius: 15,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(circularRadiusValue),
              ),
              child: CachedNetworkImage(
                // TODO: Update accordingly when official server has been published
                imageUrl: "http://$baseUrl${foodSpotThumbnail.coverImageUrl}",
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                _horizontalSpacing,
                _verticalSpacing,
                _horizontalSpacing,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryText(
                    foodSpotThumbnail.name,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        color: Color(0xFFA6A4A4),
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: foodSpotThumbnail.locationPreposition != ""
                              ? foodSpotThumbnail.locationPreposition + " "
                              : "",
                        ),
                        TextSpan(
                          text: foodSpotThumbnail.locationNearbyLandmark,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  BlocBuilder<OverridenDateCubit, OverridenDate?>(
                    builder: (context, state) {
                      late final AvailabilityStatus? availabilityStatus;
                      late final String availabilityMessage;
                      if (context
                          .read<OverridenDateCubit>()
                          .shouldOverride(foodSpotThumbnail.id)) {
                        assert(state != null);
                        availabilityStatus = null;
                        availabilityMessage = state!.reasonForOverride;
                      } else {
                        availabilityStatus =
                            foodSpotThumbnail.operatingTimes.availabilityStatus;
                        availabilityMessage = foodSpotThumbnail
                            .operatingTimes.availabilityMessage;
                      }

                      return Column(
                        children: [
                          Row(
                            children: [
                              AvailabilityStatusIcon(availabilityStatus),
                              const SizedBox(width: 7),
                              Expanded(
                                child: PrimaryText(
                                  availabilityMessage,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  lineHeight: 1.3,
                                ),
                              ),
                            ],
                          ),
                          SeeTodaysMenu(
                            mealOfferingsUrl:
                                foodSpotThumbnail.mealOfferingsUrl,
                            availabilityStatus: availabilityStatus,
                            verticalSpacing: _verticalSpacing,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
