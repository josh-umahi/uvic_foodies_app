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

      /// We don't throw exception because if there a multiple overriden dates,
      /// we simply use the last on the list
      /// Assert will throw an exception in debugging mode but will have no effect in production mode
      assert(entireJson["total"] <= 1);

      final entireJsonItems = List.from(entireJson["items"]);

      if (entireJsonItems.isNotEmpty) {
        final json = entireJsonItems.last["fields"];
        final newestOverridenDates = OverridenDate.fromJson(json);
        return newestOverridenDates;
      } else {
        return null;
      }
    } catch (e) {
      /// If an exception is thrown, simply return null (no OverridenDate) and
      /// continue the program as normal. Print the exception however, for debugging
      print(e);
      return null;
    }
  }
}
