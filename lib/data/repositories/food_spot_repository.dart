import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/food_spot/food_spot_details.dart';
import '../models/food_spot/food_spot_formatted_response.dart';
import 'contentful/contentful_helpers.dart';

class FoodSpotRepository {
  FoodSpotRepository();

  /// * Ensure to call this method first when creating new instance of this class!
  Future init() async {
    final allFoodSpotsResponse = await _getAllFoodSpotsAndImages();

    try {
      final listOfJsonFoodSpots = allFoodSpotsResponse["listOfJsonFoodSpots"]!;
      final listOfJsonImages = allFoodSpotsResponse["listOfJsonImages"]!;

      //* _mapOfIdsToImageUrls must be initialized first as it is used in creation of _mapOfIdsToFormattedFoodSpots
      _setMapOfIdsToImageUrls = listOfJsonImages;
      _setMapOfIdsToFormattedFoodSpots = listOfJsonFoodSpots;
    } catch (e) {
      // TODO: Appropriate Exception Handling
      rethrow;
    }
  }

  Map<String, String>? _mapOfIdsToImageUrls;
  Map<String, FoodSpotFormattedResponse>? _mapOfIdsToFormattedFoodSpots;

  //************************* Getters *************************/
  Map<String, String>? get getMapOfIdsToImageUrls => _mapOfIdsToImageUrls;
  Map<String, FoodSpotFormattedResponse>? get getMapOfIdsToFormattedFoodSpots =>
      _mapOfIdsToFormattedFoodSpots;

  FoodSpotDetails getFoodSpotDetailsById(
    String foodSpotId,
  ) {
    try {
      final foodSpotFormattedResponse =
          _mapOfIdsToFormattedFoodSpots![foodSpotId]!;
      final foodSpot =
          FoodSpotDetails.fromFormattedResponse(foodSpotFormattedResponse);
      return foodSpot;
    } catch (e) {
      // TODO: Appropriate Exception Handling
      rethrow;
    }
  }

  //************************* Setters *************************/
  set _setMapOfIdsToFormattedFoodSpots(List listOfJsonFoodSpots) {
    // We first initialize the map before assigning values to it
    _mapOfIdsToFormattedFoodSpots = {};

    for (var foodSpotJson in listOfJsonFoodSpots) {
      final coverImageId = foodSpotJson["fields"]["coverImage"]["sys"]["id"];
      final coverImageUrl = _getImageUrlById(coverImageId);

      final mapOfIdToFormattedFoodSpot =
          ContentfulHelpers.extractFoodSpotIdAndFormattedResponse(
        foodSpotJson,
        coverImageUrl,
      );
      _mapOfIdsToFormattedFoodSpots!.addAll(mapOfIdToFormattedFoodSpot);
    }
  }

  set _setMapOfIdsToImageUrls(List listOfJsonImages) {
    // We first initialize the map before assigning values to it
    _mapOfIdsToImageUrls = {};

    for (var imageJson in listOfJsonImages) {
      final mapOfIdToImageUrl =
          ContentfulHelpers.extractImageIdAndUrl(imageJson);
      _mapOfIdsToImageUrls!.addAll(mapOfIdToImageUrl);
    }
  }
  //**************************************************/

  /// Returns a map of keys: "listOfJsonFoodSpots" and "listOfJsonImages" containing
  /// the list of foodspot json objects and the list of image json objects respectively
  Future<Map<String, List>> _getAllFoodSpotsAndImages() async {
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
      return {
        "listOfJsonFoodSpots": json["items"] as List,
        "listOfJsonImages": json["includes"]["Asset"] as List,
      };
    } catch (e) {
      // TODO: Appropriate Exception Handling
      rethrow;
    }
  }

  String _getImageUrlById(String imageId) {
    try {
      final String imageUrl = _mapOfIdsToImageUrls![imageId]!;
      return imageUrl;
    } catch (e) {
      // TODO: Appropriate Exception Handling
      rethrow;
    }
  }
}
