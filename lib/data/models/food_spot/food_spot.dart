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

/******************** Example JSON for subclasses ******************** 
{
    "id": 1,
    "name": "Bibliocafe",
    "buildingFilterTag": null,
    "published_at": "2021-09-27T00:23:29.665Z",
    "created_at": "2021-09-27T00:03:04.320Z",
    "updated_at": "2021-09-29T19:58:26.083Z",
    "paymentPlans": {
        "id": 1,
        "usesFlexPlan": true,
        "usesMealPlan": true
    },
    "mealOfferings": {
        "id": 1,
        "asUrl": null,
        "asList": [
            "specialty coffees and teas",
            "grab-and-go sandwiches",
            "wraps and buns",
            "salads",
            "sushi",
            "pastry rolls",
            "samosas",
            "cakes",
            "squares",
            "pastries and other sweets"
        ]
    },
    "locationWithPreposition": {
        "id": 1,
        "preposition": "in the",
        "nearbyLandmark": "Uvic Library"
    },
    "hoursOfOperation": {
        "id": 1,
        "monday": "0800-2000",
        "tuesday": "0800-2000",
        "wednesday": "0800-2000",
        "thursday": "0800-2000",
        "friday": "0800-1600",
        "saturday": "!",
        "sunday": "!"
    },
    "coverImage": {
        "id": 1,
        "name": "b.jpg",
        "alternativeText": "",
        "caption": "",
        "width": 507,
        "height": 338,
        "formats": {
            "thumbnail": {
                "name": "thumbnail_b.jpg",
                "hash": "thumbnail_b_31d23c371e",
                "ext": ".jpg",
                "mime": "image/jpeg",
                "width": 234,
                "height": 156,
                "size": 7.48,
                "path": null,
                "url": "/uploads/thumbnail_b_31d23c371e.jpg"
            },
            "small": {
                "name": "small_b.jpg",
                "hash": "small_b_31d23c371e",
                "ext": ".jpg",
                "mime": "image/jpeg",
                "width": 500,
                "height": 333,
                "size": 25.22,
                "path": null,
                "url": "/uploads/small_b_31d23c371e.jpg"
            }
        },
        "hash": "b_31d23c371e",
        "ext": ".jpg",
        "mime": "image/jpeg",
        "size": 26.12,
        "url": "/uploads/b_31d23c371e.jpg",
        "previewUrl": null,
        "provider": "local",
        "provider_metadata": null,
        "created_at": "2021-09-27T00:13:33.376Z",
        "updated_at": "2021-09-27T00:13:33.386Z"
    }
}
******************************************************/
