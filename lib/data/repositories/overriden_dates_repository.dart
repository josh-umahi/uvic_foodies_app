import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/times_and_dates/overriden_date.dart';
import 'constants.dart';

/// In earlier versions of the app we'll have only 1 OverridenDate so as to esnure that
/// performance is not sacrificed for something so infrequent.
/// However, we'll keep it as a list in the backend to allow for easy modifications later on
class OverridenDatesRepository {
  const OverridenDatesRepository();

  Future<OverridenDate?> getLastOverridenDate() async {
    final uri = Uri.http(baseUrl, "/dates-overriden-to-closeds");
    final client = http.Client();
    final response = await client.get(uri);
    final json = jsonDecode(response.body) as List;

    try {
      final newestOverridenDates =
          json.isEmpty ? null : OverridenDate.fromJson(json.last);
      return newestOverridenDates;
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }
}
