abstract class ContentfulHelpers {
  //************************* Static Constants *************************/
  static const BASE_URL = "cdn.contentful.com";

  static const SPACE_ID = "mq9b8mhi78ux";

  static const ACCESS_TOKEN = "bic5n_LIfi0lzu2HR4JJLh5-KPpVRtXqOX4-Iom3cWE";

  static const CONTENT_TYPE_FOODSPOT = "foodSpot";
  static const CONTENT_TYPE_OVERRIDEN_DATE = "overridenDate";

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
}
