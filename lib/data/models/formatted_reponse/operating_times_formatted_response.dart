class OperatingTimesFormattedResponse {
  const OperatingTimesFormattedResponse({
    required this.foodSpotId,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  /// The date entries have a regex on the server that restricts them to
  /// this format: "0800-1600" or "!" to show closed
  ///
  /// In this factory constructor, we first confirm again that they conform to this same regex before
  /// we parse the values. This way we dont have to do unnecessary trimmings and validation checks within our methods.
  /// It also makes it easier for us to catch backend mistakes early
  ///
  /// For sample JSON, see response_examples folder
  factory OperatingTimesFormattedResponse.fromJson(
    Map<String, dynamic> json,
    String foodSpotId,
  ) {
    try {
      final String monday = json["hoursMonday"];
      final String tuesday = json["hoursTuesday"];
      final String wednesday = json["hoursWednesday"];
      final String thursday = json["hoursThursday"];
      final String friday = json["hoursFriday"];
      final String saturday = json["hoursSaturday"];
      final String sunday = json["hoursSunday"];

      // * Be sure to update this if you modify the backend regex
      final regex = RegExp(
        r"^([01][0-9]|2[0-3])([0-5][0-9])-([01][0-9]|2[0-3])([0-5][0-9])$|^!$",
      );

      assert([
        monday,
        tuesday,
        wednesday,
        thursday,
        friday,
        saturday,
        sunday,
      ].every((dayday) => regex.hasMatch(dayday)));

      return OperatingTimesFormattedResponse(
        foodSpotId: foodSpotId,
        monday: monday,
        tuesday: tuesday,
        wednesday: wednesday,
        thursday: thursday,
        friday: friday,
        saturday: saturday,
        sunday: sunday,
      );
    } catch (e) {
      // TODO: Appropriate Error Handling
      rethrow;
    }
  }

  final String foodSpotId;
  final String monday;
  final String tuesday;
  final String wednesday;
  final String thursday;
  final String friday;
  final String saturday;
  final String sunday;
}
