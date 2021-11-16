import '../times_and_dates/operating_times.dart';
import 'food_spot.dart';

class FoodSpotDetails extends FoodSpot {
  const FoodSpotDetails({
    required String id,
    required String name,
    required String coverImageUrl,
    required String locationPreposition,
    required String locationNearbyLandmark,
    required String? buildingFilterTagString,
    required OperatingTimes operatingTimes,
    required this.payByFlexPlan,
    required this.payByMealPlan,
    required this.mealOfferingsUrl,
    required this.mealOfferingsList,
  }) : super(
          id: id,
          name: name,
          coverImageUrl: coverImageUrl,
          locationPreposition: locationPreposition,
          locationNearbyLandmark: locationNearbyLandmark,
          mealOfferingsUrl: mealOfferingsUrl,
          buildingFilterTagString: buildingFilterTagString,
          operatingTimes: operatingTimes,
        );

  /// To see json example, refer to the FoodSpotRepository.formattedResponseBody
  factory FoodSpotDetails.fromJson(Map<String, dynamic> json) {
    try {
      final String id = json["formattedId"];
      final String name = json["formattedName"];
      final String coverImageUrl = json["formattedCoverImageUrl"];
      final bool payByFlexPlan = json["formattedPayByFlexPlan"];
      final bool payByMealPlan = json["formattedPayByMealPlan"];
      final String? mealOfferingsUrl = json["formattedMealOfferingsUrl"];
      final List<String>? mealOfferingsList =
          json["formattedMealOfferingsList"];
      final String locationPreposition = json["formattedLocationPreposition"];
      final String locationNearbyLandmark =
          json["formattedLocationNearbyLandmark"];
      final String? buildingFilterTagString =
          json["formattedBuildingFilterTagString"];
      final OperatingTimes operatingTimes = OperatingTimes.fromJson(
        json["formattedHoursOfOperation"],
        id,
      );

      return FoodSpotDetails(
        id: id,
        name: name,
        coverImageUrl: coverImageUrl,
        payByFlexPlan: payByFlexPlan,
        payByMealPlan: payByMealPlan,
        mealOfferingsUrl: mealOfferingsUrl,
        mealOfferingsList: mealOfferingsList,
        locationPreposition: locationPreposition,
        locationNearbyLandmark: locationNearbyLandmark,
        buildingFilterTagString: buildingFilterTagString,
        operatingTimes: operatingTimes,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  String toString() {
    return """
      id: $id
      name: $name
      coverImageUrl: $coverImageUrl
      locationPreposition: $locationPreposition
      locationNearbyLandmark: $locationNearbyLandmark
      buildingFilterTagString: $buildingFilterTagString
      payByFlexPlan: $payByFlexPlan
      payByMealPlan: $payByMealPlan
      mealOfferingsUrl: $mealOfferingsUrl
      mealOfferingsList: $mealOfferingsList
      availabilityStatus: ${operatingTimes.availabilityStatus}
      availabilityMessage: ${operatingTimes.availabilityMessage}
    """;
  }

  /// The payment plans allowed by this foodspot
  final bool payByFlexPlan;
  final bool payByMealPlan;

  /// The meal offerings may either be a list or a Url, not both or neither
  final String? mealOfferingsUrl;
  final List<String>? mealOfferingsList;
}
