import '../formatted_reponse/food_spot_formatted_response.dart';
import '../times_and_dates/operating_times.dart';
import 'food_spot.dart';

class FoodSpotThumbnail extends FoodSpot {
  const FoodSpotThumbnail({
    required String id,
    required String name,
    required String coverImageUrl,
    required String locationPreposition,
    required String locationNearbyLandmark,
    required String? mealOfferingsUrl,
    required String? buildingFilterTagString,
    required OperatingTimes operatingTimes,
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

  factory FoodSpotThumbnail.fromFormattedResponse(
    FoodSpotFormattedResponse formattedResponse,
  ) {
    return FoodSpotThumbnail(
      id: formattedResponse.id,
      name: formattedResponse.name,
      coverImageUrl: formattedResponse.coverImageUrl,
      locationPreposition: formattedResponse.locationPreposition,
      locationNearbyLandmark: formattedResponse.locationNearbyLandmark,
      mealOfferingsUrl: formattedResponse.mealOfferingsAsUrl,
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
      mealOfferingsUrl: $mealOfferingsUrl
      buildingFilterTagString: $buildingFilterTag
      availabilityStatus: ${operatingTimes.availabilityStatus}
      availabilityMessage: ${operatingTimes.availabilityMessage}
    """;
  }
}
