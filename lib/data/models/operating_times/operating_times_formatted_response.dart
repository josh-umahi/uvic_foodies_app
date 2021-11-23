class OperatingTimesFormattedResponse {
  const OperatingTimesFormattedResponse({
    required this.foodSpotId,
    required this.mondayHours,
    required this.tuesdayHours,
    required this.wednesdayHours,
    required this.thursdayHours,
    required this.fridayHours,
    required this.saturdayHours,
    required this.sundayHours,
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
      final String mondayHours = json["hoursMonday"];
      final String tuesdayHours = json["hoursTuesday"];
      final String wednesdayHours = json["hoursWednesday"];
      final String thursdayHours = json["hoursThursday"];
      final String fridayHours = json["hoursFriday"];
      final String saturdayHours = json["hoursSaturday"];
      final String sundayHours = json["hoursSunday"];

      // * Be sure to update this if you modify the backend regex
      final regex = RegExp(
        r"^([01][0-9]|2[0-3])([0-5][0-9])-([01][0-9]|2[0-3])([0-5][0-9])$|^!$",
      );

      final listOfHours = [
        mondayHours,
        tuesdayHours,
        wednesdayHours,
        thursdayHours,
        fridayHours,
        saturdayHours,
        sundayHours,
      ];

      if (!(listOfHours.every((dayHours) => regex.hasMatch(dayHours)))) {
        throw Exception("The hours do not all match the required format");
      }

      if (listOfHours.every((dayHours) => dayHours == "!")) {
        throw Exception(
          "The hours are all \"!\". This will cause an infinite loop in one of the later methods: OperatingTimes_getWeekdayIntOfNextOpenDay",
        );
      }

      return OperatingTimesFormattedResponse(
        foodSpotId: foodSpotId,
        mondayHours: mondayHours,
        tuesdayHours: tuesdayHours,
        wednesdayHours: wednesdayHours,
        thursdayHours: thursdayHours,
        fridayHours: fridayHours,
        saturdayHours: saturdayHours,
        sundayHours: sundayHours,
      );
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      rethrow;
    }
  }

  final String foodSpotId;
  final String mondayHours;
  final String tuesdayHours;
  final String wednesdayHours;
  final String thursdayHours;
  final String fridayHours;
  final String saturdayHours;
  final String sundayHours;
}
