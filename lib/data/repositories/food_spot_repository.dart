import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/food_spot/food_spot_formatted_response.dart';
import 'contentful/contentful_helpers.dart';

class FoodSpotRepository {
  /// Ensure to call the [init] method first when creating a new instance of this class!
  FoodSpotRepository();

  Future init() async {
    final jsonForAllFoodSpotsAndImages =
        await _getJsonForAllFoodSpotsAndImages();

    try {
      final listOfJsonFoodSpots =
          jsonForAllFoodSpotsAndImages["listOfJsonFoodSpots"]!;
      final listOfJsonImages =
          jsonForAllFoodSpotsAndImages["listOfJsonImages"]!;

      //* _mapOfIdsToImageUrls must be initialized first as it is used in creation of _foodSpotFormattedResponses
      setMapOfIdsToImageUrls = listOfJsonImages;
      setFoodSpotFormattedResponses = listOfJsonFoodSpots;
    } catch (e) {
      // TODO: Appropriate Exception Handling
      rethrow;
    }
  }

  //************************* Class Properties *************************/
  late Map<String, String> _mapOfIdsToImageUrls;
  late List<FoodSpotFormattedResponse> _foodSpotFormattedResponses;

  //************************* Getters *************************/
  Map<String, String> get getMapOfIdsToImageUrls => _mapOfIdsToImageUrls;
  List<FoodSpotFormattedResponse> get getFoodSpotFormattedResponses =>
      _foodSpotFormattedResponses;

  //************************* Setters *************************/
  set setMapOfIdsToImageUrls(List listOfJsonImages) {
    // We first initialize the map before assigning values to it
    _mapOfIdsToImageUrls = {};

    for (var imageJson in listOfJsonImages) {
      final mapOfIdToImageUrl =
          ContentfulHelpers.extractImageIdAndUrl(imageJson);
      _mapOfIdsToImageUrls.addAll(mapOfIdToImageUrl);
    }
  }

  set setFoodSpotFormattedResponses(List listOfJsonFoodSpots) {
    // We first initialize the list before assigning values to it
    _foodSpotFormattedResponses = [];

    for (var foodSpotJson in listOfJsonFoodSpots) {
      final coverImageId = foodSpotJson["fields"]["coverImage"]["sys"]["id"];
      final coverImageUrl = _mapOfIdsToImageUrls[coverImageId]!;

      /// If there is an error thrown in one of the foodSpotFormattedResponse that
      /// we're trying to create, we don't add that one to our [_foodSpotFormattedResponses]
      /// We simply skip to the next iteration of the loop. Details of the exception will
      /// be printed to console by the original try-catch block that caught it
      try {
        final foodSpotFormattedResponse = FoodSpotFormattedResponse.fromJson(
          foodSpotJson,
          coverImageUrl,
        );
        _foodSpotFormattedResponses.add(foodSpotFormattedResponse);
      } catch (e) {
        continue;
      }
    }
  }
  //**************************************************/

  /// Returns a map of keys: "listOfJsonFoodSpots" and "listOfJsonImages" containing
  /// the list of foodspot json objects and the list of image json objects respectively
  Future<Map<String, List>> _getJsonForAllFoodSpotsAndImages() async {
    /// My Postman Https Request Example:
    /// https://cdn.contentful.com/spaces/{{UVIC_FOODIES_SPACE_ID}}/entries?access_token={{UVIC_FOODIES_ACCESS_TOKEN}}&content_type={{UVIC_FOODIES_CONTENT_TYPE_ID_FOODSPOTS}}
    final queryParameters = {
      "access_token": ContentfulHelpers.ACCESS_TOKEN,
      "content_type": ContentfulHelpers.CONTENT_TYPE_FOODSPOT,
    };
    final uri = Uri.https(
      ContentfulHelpers.BASE_URL,
      "spaces/${ContentfulHelpers.SPACE_ID}/entries",
      queryParameters,
    );

    final client = http.Client();
    try {
      final response = await client.get(uri);

      /// The "http" package instructs to run this method after client is
      /// no longer being used in order to prevent memory leak
      client.close();

      final json = jsonDecode(response.body);
      final jsonItemsLength = json["total"];

      return {
        "listOfJsonFoodSpots":
            jsonItemsLength == 0 ? [] : json["items"] as List,
        "listOfJsonImages":
            jsonItemsLength == 0 ? [] : json["includes"]["Asset"] as List,
      };
    } catch (e) {
      // TODO: Appropriate Exception Handling
      rethrow;
    }
  }
}
