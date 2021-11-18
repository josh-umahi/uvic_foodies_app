import 'operating_times_formatted_response.dart';

class FoodSpotFormattedResponse {
  FoodSpotFormattedResponse({
    required this.id,
    required this.name,
    required this.coverImageUrl,
    required this.paymentsByFlexPlan,
    required this.paymentsByMealPlan,
    required this.mealOfferingsAsUrl,
    required this.mealOfferingsAsList,
    required this.locationPreposition,
    required this.locationNearbyLandmark,
    required this.buildingFilterTag,
    required this.operatingTimesFormattedResponse,
  });

  factory FoodSpotFormattedResponse.fromJson(
    Map<String, dynamic> json,
    String coverImageExtractedlUrl,
  ) {
    try {
      final foodSpotId = json["sys"]["id"];
      final fieldsJson = json["fields"];
      final nullableMealOfferingsAsList = fieldsJson["mealOfferingsAsList"];

      final String id = foodSpotId;
      final String name = fieldsJson["name"];
      final String coverImageUrl = coverImageExtractedlUrl;
      final bool paymentsByFlexPlan = fieldsJson["paymentsByFlexPlan"];
      final bool paymentsByMealPlan = fieldsJson["paymentsByMealPlan"];
      final String? mealOfferingsAsUrl = fieldsJson["mealOfferingsAsUrl"];
      final List<String>? mealOfferingsAsList =
          nullableMealOfferingsAsList == null
              ? null
              : List<String>.from(nullableMealOfferingsAsList);
      final String locationPreposition = fieldsJson["locationPreposition"];
      final String locationNearbyLandmark =
          fieldsJson["locationNearbyLandmark"];
      final String? buildingFilterTag = fieldsJson["buildingFilterTag"];
      final operatingTimesFormattedResponse =
          OperatingTimesFormattedResponse.fromJson(fieldsJson, foodSpotId);

      // Asserts that exactly one method of displaying meal offerings is null
      assert((mealOfferingsAsUrl == null && mealOfferingsAsList != null) ||
          (mealOfferingsAsUrl != null && mealOfferingsAsList == null));

      return FoodSpotFormattedResponse(
        id: id,
        name: name,
        coverImageUrl: coverImageUrl,
        paymentsByFlexPlan: paymentsByFlexPlan,
        paymentsByMealPlan: paymentsByMealPlan,
        mealOfferingsAsUrl: mealOfferingsAsUrl,
        mealOfferingsAsList: mealOfferingsAsList,
        locationPreposition: locationPreposition,
        locationNearbyLandmark: locationNearbyLandmark,
        buildingFilterTag: buildingFilterTag,
        operatingTimesFormattedResponse: operatingTimesFormattedResponse,
      );
    } catch (e) {
      // TODO: Appropriate Error Handling
      rethrow;
    }
  }

  final String id;
  final String name;
  final String coverImageUrl;
  final bool paymentsByFlexPlan;
  final bool paymentsByMealPlan;
  final String? mealOfferingsAsUrl;
  final List<String>? mealOfferingsAsList;
  final String locationPreposition;
  final String locationNearbyLandmark;
  final String? buildingFilterTag;
  final OperatingTimesFormattedResponse operatingTimesFormattedResponse;
}
