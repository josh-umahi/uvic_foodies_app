class OverridenDate {
  /// This holds the date interval and reason for a temporary override. It will be
  /// used to override the displayed availability status and message for the foodspots in temporary
  /// situations where campus hours may differ be for reasons like reading break etc
  ///
  /// The [idsToExclude] list contains the IDs of the foodspots to be excluded from this
  /// overriden date instance
  const OverridenDate({
    required this.dateStart,
    required this.dateAfterDateEnd,
    required this.reasonForOverride,
    required this.idsToExclude,
  });

  /// For sample JSON, see bottom of the page
  factory OverridenDate.fromJson(Map<String, dynamic> json) {
    try {
      /// The dates parsed contain only day, month and year. We chose to exclude
      /// the hours and minutes from the backend to prevent timezone conflict issues.
      /// So for the dateAfterDateEnd we manually set it to one day after the backend's dateEnd
      final DateTime dateStart = DateTime.parse(json["dateStartInclusive"]);
      final DateTime dateAfterDateEnd =
          DateTime.parse(json["dateEndInclusive"]).add(const Duration(days: 1));
      final String reasonForOverride = json["reasonForOverride"];
      final List<String> idsToExclude = List<String>.from(json["idsToExclude"]);
      assert(dateAfterDateEnd.isAfter(dateStart));

      return OverridenDate(
        dateStart: dateStart,
        dateAfterDateEnd: dateAfterDateEnd,
        reasonForOverride: reasonForOverride,
        idsToExclude: idsToExclude,
      );
    } catch (e) {
      rethrow;
    }
  }

  bool get todayIsOverriden {
    final timeNow = DateTime.now();
    return timeNow.isAfter(dateStart.subtract(Duration(milliseconds: 1))) &&
        timeNow.isBefore(dateAfterDateEnd);
  }

  @override
  String toString() {
    return """
      dateStart: $dateStart
      dateEnd: $dateAfterDateEnd
      reasonForOverride: $reasonForOverride
      idsToExclude: $idsToExclude
  """;
  }

  final DateTime dateStart;
  final DateTime dateAfterDateEnd;
  final String reasonForOverride;
  final List<String> idsToExclude;
}

/******************** Sample JSON ********************
{
    "id": 1,
    "dateStart": "2021-11-10",
    "dateEnd": "2021-11-12",
    "reasonForOverride": "Closed for Reading Break",
    "idsToExclude": [
        "1"
    ],
    "published_at": "2021-10-11T15:03:31.161Z",
    "created_at": "2021-10-11T14:44:21.437Z",
    "updated_at": "2021-10-11T15:03:31.170Z"
}
******************************************************/
