import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/overriden_date/overriden_date.dart';
import 'contentful/contentful_helpers.dart';

/// In earlier versions of the app we'll have only 1 OverridenDate so as to esnure that
/// performance is not sacrificed for something so infrequent.
/// However, we'll keep it as a list in the backend to allow for easy modifications later on
class OverridenDatesRepository {
  const OverridenDatesRepository();

  Future<OverridenDate?> getLastOverridenDate() async {
    /// My Postman Https Request Example:
    /// https://cdn.contentful.com/spaces/{{UVIC_FOODIES_SPACE_ID}}/entries?access_token={{UVIC_FOODIES_ACCESS_TOKEN}}&content_type={{UVIC_FOODIES_CONTENT_TYPE_ID_OVERRIDEN_DATES}}
    final queryParameters = {
      "access_token": ContentfulHelpers.ACCESS_TOKEN,
      "content_type": ContentfulHelpers.CONTENT_TYPE_OVERRIDEN_DATE,
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

      final entireJson = jsonDecode(response.body);

      /// In debug mode, assert that there must be at most 1 overriden date,
      if(entireJson["total"] > 1){ 
        throw Exception(
          "Number of Overriden Dates is greater than 1",
        );
      }

      final entireJsonItems = List.from(entireJson["items"]);

      /// There should be at most 1 overriden date,
      /// If there are multiple, we disregard all of them and return null
      /// This is to discourage me from publishing multiple Overriden Dates to
      /// the CDN while the app currently doesn't support it
      if (entireJsonItems.length == 1) {
        final json = entireJsonItems[0]["fields"];
        final newestOverridenDates = OverridenDate.fromJson(json);
        return newestOverridenDates;
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      return null;
    }
  }
}
