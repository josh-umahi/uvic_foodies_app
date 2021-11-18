import '../formatted_reponse/food_spot_formatted_response.dart';
import '../times_and_dates/operating_times.dart';
import 'food_spot.dart';

class FoodSpotDetails extends FoodSpot {
  const FoodSpotDetails({
    required String id,
    required String name,
    required String coverImageUrl,
    required String locationPreposition,
    required String locationNearbyLandmark,
    required String? mealOfferingsUrl,
    required String? buildingFilterTagString,
    required OperatingTimes operatingTimes,
    required this.payByFlexPlan,
    required this.payByMealPlan,
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

  factory FoodSpotDetails.fromFormattedResponse(
    FoodSpotFormattedResponse formattedResponse,
  ) {
    return FoodSpotDetails(
      id: formattedResponse.id,
      name: formattedResponse.name,
      coverImageUrl: formattedResponse.coverImageUrl,
      payByFlexPlan: formattedResponse.paymentsByFlexPlan,
      payByMealPlan: formattedResponse.paymentsByMealPlan,
      mealOfferingsUrl: formattedResponse.mealOfferingsAsUrl,
      mealOfferingsList: formattedResponse.mealOfferingsAsList,
      locationPreposition: formattedResponse.locationPreposition,
      locationNearbyLandmark: formattedResponse.locationNearbyLandmark,
      buildingFilterTagString: formattedResponse.buildingFilterTag,
      operatingTimes: OperatingTimes.fromFormattedResponse(
        formattedResponse.operatingTimesFormattedResponse,
      ),
    );
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

  final bool payByFlexPlan;
  final bool payByMealPlan;
  final List<String>? mealOfferingsList;
}
