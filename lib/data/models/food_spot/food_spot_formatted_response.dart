import '../operating_times/operating_times_formatted_response.dart';
import 'food_spot.dart';

class FoodSpotFormattedResponse extends FoodSpot {
  final OperatingTimesFormattedResponse operatingTimesFormattedResponse;

  const FoodSpotFormattedResponse({
    required this.operatingTimesFormattedResponse,
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
      final String? buildingFilterTagString = fieldsJson["buildingFilterTag"];
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
        buildingFilterTagString: buildingFilterTagString,
        operatingTimesFormattedResponse: operatingTimesFormattedResponse,
      );
    } catch (e) {
      // TODO: Appropriate Error Handling
      rethrow;
    }
  }

  @override
  String toString() {
    return """
      ${super.toString()}
      operatingTimesFormattedResponse: $operatingTimesFormattedResponse
    """;
  }
}
