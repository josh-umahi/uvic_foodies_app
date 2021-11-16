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

  /// To see json example, refer to the FoodSpotRepository.formattedResponseBody
  factory FoodSpotThumbnail.fromJson(Map<String, dynamic> json) {
    try {
      final String id = json["formattedId"];
      final String name = json["formattedName"];
      final String coverImageUrl = json["formattedCoverImageUrl"];
      final String locationPreposition = json["formattedLocationPreposition"];
      final String locationNearbyLandmark =
          json["formattedLocationNearbyLandmark"];
      final String? mealOfferingsUrl = json["formattedMealOfferingsUrl"];
      final String? buildingFilterTagString =
          json["formattedBuildingFilterTagString"];
      final OperatingTimes operatingTimes = OperatingTimes.fromJson(
        json["formattedHoursOfOperation"],
        id,
      );

      return FoodSpotThumbnail(
        id: id,
        name: name,
        coverImageUrl: coverImageUrl,
        locationPreposition: locationPreposition,
        locationNearbyLandmark: locationNearbyLandmark,
        mealOfferingsUrl: mealOfferingsUrl,
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
      mealOfferingsUrl: $mealOfferingsUrl
      buildingFilterTagString: $buildingFilterTag
      availabilityStatus: ${operatingTimes.availabilityStatus}
      availabilityMessage: ${operatingTimes.availabilityMessage}
    """;
  }
}
