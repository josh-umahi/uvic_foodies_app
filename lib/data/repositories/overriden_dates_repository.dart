import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/times_and_dates/overriden_date.dart';
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
      assert(entireJson["total"] == 0 || entireJson["total"] == 1);

      final json = List.from(entireJson["items"]).first["fields"];
      final newestOverridenDates = OverridenDate.fromJson(json);
      return newestOverridenDates;
    } catch (e) {
      // TODO: Appropriate Error Handling
      rethrow;
    }
  }
}
