import '../enums.dart';
import '../times_and_dates/operating_times.dart';

class FoodSpot {
  const FoodSpot({
    required this.id,
    required this.name,
    required this.coverImageUrl,
    required this.locationPreposition,
    required this.locationNearbyLandmark,
    required this.mealOfferingsUrl,
    required this.buildingFilterTagString,
    required this.operatingTimes,
  });

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

  final String id;
  final String name;

  /// The url for the cover image, but without the domain name
  final String coverImageUrl;

  /// For example, locationPreposition = "in the" and locationNearbyLandmark = "Library".
  /// This may be used to give student a better description of where the foodspot is. They
  /// are separated in other to allow for different styling
  final String locationPreposition;
  final String locationNearbyLandmark;

  /// This could be null because the meal offerings may be a list
  final String? mealOfferingsUrl;

  /// To enable filter-by-building for cases where one building houses multiple foodspots
  final String? buildingFilterTagString;

  final OperatingTimes operatingTimes;
}
 