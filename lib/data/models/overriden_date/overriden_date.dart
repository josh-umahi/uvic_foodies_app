class OverridenDate {
  /// This holds the date interval and reason for a temporary override. It will be
  /// used to override the displayed availability status and message for the foodspots
  /// in temporary situations where campus hours may differ be for reasons like reading break etc
  ///
  /// The [idsToExclude] list contains the IDs of the foodspots to be excluded from this
  /// overriden date instance
  const OverridenDate({
    required this.dateStart,
    required this.dateEnd,
    required this.reasonForOverride,
    required this.idsToExclude,
  });

  factory OverridenDate.fromJson(Map<String, dynamic> json) {
    try {
      /// The dates parsed contain only day, month and year. The time defaults to 00:00
      /// We chose to exclude the hours and minutes from the backend to prevent timezone conflict issues.
      /// So for the dateEnd we manually set it to one day after the backend's dateEndInclusive
      final dateStart = DateTime.parse(json["dateStartInclusive"]);
      final dateEnd = DateTime.parse(json["dateEndInclusive"]).add(
        const Duration(days: 1),
      );

      if (dateEnd.isBefore(dateStart)) {
        throw ("dateEnd is before dateStart");
      }

      final nullableListOfFoodSpotJsonsToExclude = json["foodSpotsToExclude"];
      final List listOfFoodSpotJsonsToExclude =
          nullableListOfFoodSpotJsonsToExclude == null
              ? []
              : List.from(nullableListOfFoodSpotJsonsToExclude);

      List<String> idsToExclude = [];
      if (listOfFoodSpotJsonsToExclude.isNotEmpty) {
        for (var foodSpotJson in listOfFoodSpotJsonsToExclude) {
          idsToExclude.add(foodSpotJson["sys"]["id"] as String);
        }

        // Removes duplicates, therefore shortening duration of iterations through our list
        idsToExclude = idsToExclude.toSet().toList();
      }

      final String reasonForOverride = json["reasonForOverride"];

      return OverridenDate(
        dateStart: dateStart,
        dateEnd: dateEnd,
        reasonForOverride: reasonForOverride,
        idsToExclude: idsToExclude,
      );
    } catch (e) {
      rethrow;
    }
  }

  bool get todayIsOverriden {
    final timeNow = DateTime.now();
    return timeNow
            .isAfter(dateStart.subtract(const Duration(milliseconds: 1))) &&
        timeNow.isBefore(dateEnd);
  }

  @override
  String toString() {
    return """
      dateStart: $dateStart
      dateEnd: $dateEnd
      reasonForOverride: $reasonForOverride
      idsToExclude: $idsToExclude
  """;
  }

  final DateTime dateStart;
  final DateTime dateEnd;
  final String reasonForOverride;
  final List<String> idsToExclude;
}
