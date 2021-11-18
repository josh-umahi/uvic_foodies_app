import '../../models/formatted_reponse/food_spot_formatted_response.dart';

abstract class ContentfulHelpers {
  //************************* Static Constants *************************/
  static const BASE_URL = "cdn.contentful.com";

  static const SPACE_ID = "mq9b8mhi78ux";

  static const ACCESS_TOKEN = "bic5n_LIfi0lzu2HR4JJLh5-KPpVRtXqOX4-Iom3cWE";

  static const CONTENT_TYPE_FOODSPOT = "foodSpot";

  //************************* Static Functions *************************/
  static Map<String, String> extractImageIdAndUrl(
    Map<String, dynamic> imageJson,
  ) {
    try {
      final imageId = imageJson["sys"]["id"];
      final imageUrl = "https:${imageJson["fields"]["file"]["url"]}";

      return {
        imageId: imageUrl,
      };
    } catch (e) {
      // TODO: Appropriate Error Handling
      rethrow;
    }
  }

  static Map<String, FoodSpotFormattedResponse>
      extractFoodSpotIdAndFormattedResponse(
    Map<String, dynamic> foodSpotJson,
    String coverImageUrl,
  ) {
    try {
      final foodSpotId = foodSpotJson["sys"]["id"];

      return {
        foodSpotId: FoodSpotFormattedResponse.fromJson(
          foodSpotJson,
          coverImageUrl,
        ),
      };
    } catch (e) {
      // TODO: Appropriate Error Handling
      rethrow;
    }
  }
}
