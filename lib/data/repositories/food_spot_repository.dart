import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/food_spot/food_spot_details.dart';
import '../models/food_spot/food_spot_thumbnail.dart';
import 'constants.dart';

class FoodSpotRepository {
  const FoodSpotRepository();

  Future<List<FoodSpotThumbnail>> getAllFoodSpotThumbnails() async {
    final uri = Uri.http(baseUrl, "/food-spots");
    final client = http.Client();
    final response = await client.get(uri);
    final responseBodyList = jsonDecode(response.body) as List;

    try {
      final List<FoodSpotThumbnail> foodSpotThumbnail = [];
      for (var responseBodyElement in responseBodyList) {
        final json = _formattedResponseBody(responseBodyElement);
        foodSpotThumbnail.add(FoodSpotThumbnail.fromJson(json));
      }
      return foodSpotThumbnail;
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }

  Future<FoodSpotDetails> getFoodSpotDetailsById(String id) async {
    final uri = Uri.http(baseUrl, "/food-spots/$id");
    final client = http.Client();
    final response = await client.get(uri);
    final responseBody = jsonDecode(response.body);
    final json = _formattedResponseBody(responseBody, withAllDetails: true);

    try {
      return FoodSpotDetails.fromJson(json);
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }

  /// This method formats the response body of the http requests so they resemble a
  /// standard format for use in the fromJson constructor of FoodSpot subclasses:
  /// FoodSpotThumbnail and FoodSpotDetails
  ///
  /// The [withAllDetails] parameter determines whether the returned json should contain
  /// all the foodSpot details or not. It defaults to false and should be left that way when
  /// intended to be used for the FoodSpotThumbnail.fromJson constructor and true when being
  /// used with the FoodSpotDetails.fromJson
  ///
  /// To see json example, refer to the FoodSpot superclass
  Map<String, dynamic> _formattedResponseBody(
    dynamic json, {
    bool withAllDetails = false,
  }) {
    final Map<String, dynamic> formattedResponseBody = {};

    formattedResponseBody["formattedId"] = json["id"].toString();
    formattedResponseBody["formattedName"] = json["name"];
    formattedResponseBody["formattedCoverImageUrl"] = json["coverImage"]["url"];
    formattedResponseBody["formattedLocationPreposition"] =
        json["locationWithPreposition"]["preposition"];
    formattedResponseBody["formattedLocationNearbyLandmark"] =
        json["locationWithPreposition"]["nearbyLandmark"];
    formattedResponseBody["formattedBuildingFilterTagString"] =
        json["buildingFilterTag"];
    formattedResponseBody["formattedHoursOfOperation"] =
        Map<String, dynamic>.from(json["hoursOfOperation"]);

    /// Obtained here because we use this on the thumbnails page
    /// for the "SEE TODAY'S MENU" button
    formattedResponseBody["formattedMealOfferingsUrl"] =
        json["mealOfferings"]["asUrl"];

    if (withAllDetails) {
      formattedResponseBody["formattedPayByFlexPlan"] =
          json["paymentPlans"]["usesFlexPlan"];
      formattedResponseBody["formattedPayByMealPlan"] =
          json["paymentPlans"]["usesMealPlan"];

      dynamic mealOfferingsDynamicListOrNull = json["mealOfferings"]["asList"];
      formattedResponseBody["formattedMealOfferingsList"] =
          mealOfferingsDynamicListOrNull == null
              ? null
              : List<String>.from(mealOfferingsDynamicListOrNull);

      // Asserts that exactly one method of displaying meal offerings is null
      assert((formattedResponseBody["formattedMealOfferingsUrl"] == null &&
              formattedResponseBody["formattedMealOfferingsList"] != null) ||
          (formattedResponseBody["formattedMealOfferingsUrl"] != null &&
              formattedResponseBody["formattedMealOfferingsList"] == null));
    }

    return formattedResponseBody;
  }
}
