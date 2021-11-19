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

  factory OverridenDate.fromJson(Map<String, dynamic> json) {
    try {
      /// TODO: Rewrite these
      /// The dates parsed contain only day, month and year. We chose to exclude
      /// the hours and minutes from the backend to prevent timezone conflict issues.
      /// So for the dateAfterDateEnd we manually set it to one day after the backend's dateEnd
      final DateTime dateStart = DateTime.parse(json["dateStartInclusive"]);
      final DateTime dateAfterDateEnd =
          DateTime.parse(json["dateEndInclusive"]).add(const Duration(days: 1));
      assert(dateAfterDateEnd.isAfter(dateStart));

      final List listOfFoodSpotJsonsToExclude =
          json["foodSpotsToExclude"] as List;
      final List<String> idsToExclude = [];
      for (var foodSpotJsons in listOfFoodSpotJsonsToExclude) {
        idsToExclude.add(foodSpotJsons["sys"]["id"] as String);
      }

      final String reasonForOverride = json["reasonForOverride"];

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
