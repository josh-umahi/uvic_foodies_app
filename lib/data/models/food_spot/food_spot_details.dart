import '../enums.dart';
import '../operating_times/operating_times.dart';
import 'food_spot.dart';
import 'food_spot_formatted_response.dart';

class FoodSpotDetails extends FoodSpot {
  final OperatingTimes operatingTimes;

  const FoodSpotDetails({
    required this.operatingTimes,
    required String id,
    required String name,
    required String coverImageUrl,
    required bool paymentsByFlexPlan,
    required bool paymentsByMealPlan,
    required String? mealOfferingsAsUrl,
    required List<String>? mealOfferingsAsList,
    required String locationPreposition,
    required String locationNearbyLandmark,
    required String? buildingFilterTagString,
  }) : super(
          id: id,
          name: name,
          coverImageUrl: coverImageUrl,
          paymentsByFlexPlan: paymentsByFlexPlan,
          paymentsByMealPlan: paymentsByMealPlan,
          mealOfferingsAsUrl: mealOfferingsAsUrl,
          mealOfferingsAsList: mealOfferingsAsList,
          locationPreposition: locationPreposition,
          locationNearbyLandmark: locationNearbyLandmark,
          buildingFilterTagString: buildingFilterTagString,
        );

  factory FoodSpotDetails.fromFormattedResponse(
    FoodSpotFormattedResponse formattedResponse,
  ) {
    return FoodSpotDetails(
      id: formattedResponse.id,
      name: formattedResponse.name,
      coverImageUrl: formattedResponse.coverImageUrl,
      paymentsByFlexPlan: formattedResponse.paymentsByFlexPlan,
      paymentsByMealPlan: formattedResponse.paymentsByMealPlan,
      mealOfferingsAsUrl: formattedResponse.mealOfferingsAsUrl,
      mealOfferingsAsList: formattedResponse.mealOfferingsAsList,
      locationPreposition: formattedResponse.locationPreposition,
      locationNearbyLandmark: formattedResponse.locationNearbyLandmark,
      buildingFilterTagString: formattedResponse.buildingFilterTagString,
      operatingTimes: OperatingTimes.fromFormattedResponse(
        formattedResponse.operatingTimesFormattedResponse,
      ),
    );
  }

  @override
  String toString() {
    return """
      ${super.toString()}
      buildingFilterTag: $buildingFilterTag
      availabilityStatus: ${operatingTimes.availabilityStatus}
      availabilityMessage: ${operatingTimes.availabilityMessage}
    """;
  }

  /// * Update this method if we include more buildingFilterTagString options in the backend
  BuildingFilterTag get buildingFilterTag {
    switch (buildingFilterTagString) {
      case "TheMOD":
        return BuildingFilterTag.TheMOD;
      case "MysticMarket":
        return BuildingFilterTag.MysticMarket;
      case "TheSub":
        return BuildingFilterTag.TheSub;
      default:
        return BuildingFilterTag.None;
    }
  }
}
