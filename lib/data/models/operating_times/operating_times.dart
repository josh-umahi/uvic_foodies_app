import '../enums.dart';
import 'operating_times_formatted_response.dart';

/// This class is in charge of all the time data of the foodSpot such as:
/// - daily hours of operation,
/// - availabilty status (if open now, closed, etc)
/// - when it'll be closing or opening next,
/// - and more!!
class OperatingTimes {
  OperatingTimes({
    required this.monHoursWithDash,
    required this.tueHoursWithDash,
    required this.wedHoursWithDash,
    required this.thuHoursWithDash,
    required this.friHoursWithDash,
    required this.satHoursWithDash,
    required this.sunHoursWithDash,
    required this.foodSpotId,
    required this.dateTimeNow,
  }) {
    //TODO: Replace this with all the OperatingTimes.fromJson body and remove OperatingTimes.fromJson !!!
  }

  factory OperatingTimes.fromFormattedResponse(
      OperatingTimesFormattedResponse formattedResponse) {
    return OperatingTimes(
      foodSpotId: formattedResponse.foodSpotId,
      monHoursWithDash: formattedResponse.monday,
      tueHoursWithDash: formattedResponse.tuesday,
      wedHoursWithDash: formattedResponse.wednesday,
      thuHoursWithDash: formattedResponse.thursday,
      friHoursWithDash: formattedResponse.friday,
      satHoursWithDash: formattedResponse.saturday,
      sunHoursWithDash: formattedResponse.sunday,
      dateTimeNow: DateTime.now(),
    );
  }

  @override
  String toString() {
    return """
      foodSpotId: $foodSpotId
      dateTimeNow: $dateTimeNow
      monHoursWithDash: $monHoursWithDash
      tueHoursWithDash: $tueHoursWithDash
      wedHoursWithDash: $wedHoursWithDash
      thuHoursWithDash: $thuHoursWithDash
      friHoursWithDash: $friHoursWithDash
      satHoursWithDash: $satHoursWithDash
      sunHoursWithDash: $sunHoursWithDash
    """;
  }

  bool get isOpenNow => availabilityStatus == AvailabilityStatus.OpenNow;

  AvailabilityStatus get availabilityStatus {
    if (openAndCloseTimeOfToday == null) {
      return AvailabilityStatus.ReOpensAnotherDay;
    } else {
      assert(openAndCloseTimeOfToday!.length == 2);
      final openTimeToday = _createDateTimeInstance(
        dateTimeNow,
        openAndCloseTimeOfToday![0],
      );
      final closeTimeToday = _createDateTimeInstance(
        dateTimeNow,
        openAndCloseTimeOfToday![1],
      );
      return _calculateAvailabilityStatus(
        dateTimeNow,
        openTimeToday,
        closeTimeToday,
      );
    }
  }

  String get availabilityMessage {
    if (availabilityStatus == AvailabilityStatus.ReOpensAnotherDay ||
        openAndCloseTimeOfToday == null) {
      return _calculateAvailabilityMessage(
        availabilityStatus,
        weekdayIntOfNextOpenDay:
            _getWeekdayIntOfNextOpenDay(dateTimeNow.weekday),
      );
    } else {
      final openTimeToday = openAndCloseTimeOfToday![0];
      final closeTimeToday = openAndCloseTimeOfToday![1];

      if (availabilityStatus == AvailabilityStatus.OpenNow) {
        return _calculateAvailabilityMessage(
          availabilityStatus,
          closeTimeToday: closeTimeToday,
        );
      } else if (availabilityStatus == AvailabilityStatus.ReOpensLaterToday) {
        return _calculateAvailabilityMessage(
          availabilityStatus,
          upcomingOpenTimeToday: openTimeToday,
        );
      } else {
        assert(availabilityStatus == AvailabilityStatus.ReOpensAnotherDay);
        return _calculateAvailabilityMessage(
          availabilityStatus,
          weekdayIntOfNextOpenDay:
              _getWeekdayIntOfNextOpenDay(dateTimeNow.weekday),
        );
      }
    }
  }

  List<String>? get openAndCloseTimeOfToday =>
      getOpenAndCloseTimeOfDate(dateTimeNow.weekday);

  /// This method returns:
  /// - AvailabilityStatus.OpenNow if [dateTimeNow] is in between [openTimeToday] and [closeTimeToday]
  /// - AvailabilityStatus.ReOpensLaterToday if [dateTimeNow] is before [openTimeToday] and it's the same
  /// day (we can correctly assume it's always going to be the same day because both [openTimeToday] and
  /// [closeTimeToday] are constructed from [dateTimeNow] using [_createDateTimeInstance]
  /// - AvailabilityStatus.ReOpensAnotherDay if doesn't meet the above criteria
  AvailabilityStatus _calculateAvailabilityStatus(
    DateTime timeNow,
    DateTime openTimeToday,
    DateTime closeTimeToday,
  ) {
    assert(closeTimeToday.isAfter(openTimeToday));

    if (timeNow.isAfter(openTimeToday.subtract(Duration(milliseconds: 1))) &&
        timeNow.isBefore(closeTimeToday)) {
      return AvailabilityStatus.OpenNow;
    } else if (timeNow.isBefore(openTimeToday)) {
      assert(timeNow.year == openTimeToday.year &&
          timeNow.month == openTimeToday.month &&
          timeNow.day == openTimeToday.day);
      return AvailabilityStatus.ReOpensLaterToday;
    } else {
      return AvailabilityStatus.ReOpensAnotherDay;
    }
  }

  /// Returns an availabilityMessage based on the availabilityStatus.
  /// - AvailabilityStatus.OpenNow: "Open till __"
  /// - AvailabilityStatus.ReOpensLaterToday: "Re-opens at ___ today"
  /// - AvailabilityStatus.ReOpensAnotherDay: "Re-opens on ___ by ___"
  ///
  /// TODO: Debug this and its underlying methods intensely
  String _calculateAvailabilityMessage(
    AvailabilityStatus availabilityStatus, {
    String? closeTimeToday,
    String? upcomingOpenTimeToday,
    int? weekdayIntOfNextOpenDay,
  }) {
    assert(availabilityStatus == AvailabilityStatus.OpenNow ||
        availabilityStatus == AvailabilityStatus.ReOpensLaterToday ||
        availabilityStatus == AvailabilityStatus.ReOpensAnotherDay);

    if (availabilityStatus == AvailabilityStatus.OpenNow) {
      assert(closeTimeToday != null);

      final String closeTimeTodayAsFormattedTwelveHour =
          _convertToTwelveHourString(closeTimeToday!, removeZeroMinutes: true);
      return "Open till $closeTimeTodayAsFormattedTwelveHour";
    } else if (availabilityStatus == AvailabilityStatus.ReOpensLaterToday) {
      assert(upcomingOpenTimeToday != null);

      final String upcomingOpenTimeTodayAsFormattedTwelveHour =
          _convertToTwelveHourString(upcomingOpenTimeToday!,
              removeZeroMinutes: true);
      return "Re-opens at $upcomingOpenTimeTodayAsFormattedTwelveHour today";
    } else {
      assert(availabilityStatus == AvailabilityStatus.ReOpensAnotherDay &&
          weekdayIntOfNextOpenDay != null);

      final String nextOpenDayString =
          _getWeekdayString(weekdayIntOfNextOpenDay!);
      final String nextOpenTime =
          getOpenAndCloseTimeOfDate(weekdayIntOfNextOpenDay)![0];
      final String nextOpenTimeAsFormattedTwelveHour =
          _convertToTwelveHourString(nextOpenTime, removeZeroMinutes: true);
      return "Re-opens on $nextOpenDayString by $nextOpenTimeAsFormattedTwelveHour";
    }
  }

  /// Takes in the current weekday integer and returns the next open day's weekday integer
  /// The weekday integer falls in the inclusive range of 1...7
  int _getWeekdayIntOfNextOpenDay(int currentWeekdayInt) {
    final allHoursListed = [
      monHoursWithDash,
      tueHoursWithDash,
      wedHoursWithDash,
      thuHoursWithDash,
      friHoursWithDash,
      satHoursWithDash,
      sunHoursWithDash,
    ];

    // * Ensure that the hours of a single foodspot are never all exclamationMark at once as this causes an infinity loop here!!
    // * If you would like to override them, use the OverridenDate functionality instead
    assert(!(allHoursListed.every((hours) => hours == exclamationMark)));

    // * This is set to exclamationMark only to ensure the while loop is looped through at least once
    String weekdayHoursWithDash = exclamationMark;

    int weekdayInt = currentWeekdayInt;
    while (weekdayHoursWithDash == exclamationMark) {
      (weekdayInt > 6) ? weekdayInt = 1 : weekdayInt += 1;

      // * Indexes of a List begin at 0 but weekday integers begins at 1 so we must subtract 1
      weekdayHoursWithDash = allHoursListed[weekdayInt - 1];
    }

    return weekdayInt;
  }

  /// Return the String equivalent of the [weekdayInt] parameter
  ///
  /// The [weekdayInt] is in the inclusive range 1...7 with Monday
  /// being the value 1.
  String _getWeekdayString(int weekdayInt) {
    assert(weekdayInt >= 1 && weekdayInt <= 7);

    switch (weekdayInt) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      default:
        return "Sunday";
    }
  }

  /// Return a deep copy of the [dateTime] parameter with new values for its hour and minute property
  /// from our [twentyFourHourTime] parameter
  ///
  /// The [twentyFourHourTime] parameter is in the format "0930"
  DateTime _createDateTimeInstance(
    DateTime dateTime,
    String twentyFourHourTime,
  ) {
    assert(twentyFourHourTime.length == 4);
    final int hour = int.parse(twentyFourHourTime.substring(0, 2));
    final int minute = int.parse(twentyFourHourTime.substring(2, 4));

    return DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      hour,
      minute,
    );
  }

  /// Takes in an int with inclusive range of 1...7 and returns the work hours of that day
  /// as a List by utilizing the [_getOpenAndCloseTimeAsList] method
  ///
  /// * This method is left as public because it is used in unit testing
  List<String>? getOpenAndCloseTimeOfDate(int dateTimeWeekday) {
    assert(dateTimeWeekday >= 1 && dateTimeWeekday <= 7);

    late final String workHoursForToday;
    switch (dateTimeWeekday) {
      case DateTime.monday:
        workHoursForToday = monHoursWithDash;
        break;
      case DateTime.tuesday:
        workHoursForToday = tueHoursWithDash;
        break;
      case DateTime.wednesday:
        workHoursForToday = wedHoursWithDash;
        break;
      case DateTime.thursday:
        workHoursForToday = thuHoursWithDash;
        break;
      case DateTime.friday:
        workHoursForToday = friHoursWithDash;
        break;
      case DateTime.saturday:
        workHoursForToday = satHoursWithDash;
        break;
      default:
        workHoursForToday = sunHoursWithDash;
        break;
    }

    return _getOpenAndCloseTimeAsList(workHoursForToday);
  }

  /// Returns a map of all the dayIndexes to the operation hours as formatted 12-hour times
  ///
  /// Remember that the dayIndex begins at 1 for Monday, because DateTime.monday
  /// holds the number 1
  // Map<int, String> getAllFormattedOpenAndCloseTwelveHourTimes() {
  //   final Map<int, String> mapToUnformattedOpenAndCloseStrings = {
  //     DateTime.monday: monHoursWithDash,
  //     DateTime.tuesday: tueHoursWithDash,
  //     DateTime.wednesday: wedHoursWithDash,
  //     DateTime.thursday: thuHoursWithDash,
  //     DateTime.friday: friHoursWithDash,
  //     DateTime.saturday: satHoursWithDash,
  //     DateTime.sunday: sunHoursWithDash,
  //   };

  //   final Map<int, String> mapToFormattedOpenAndCloseStrings =
  //       mapToUnformattedOpenAndCloseStrings.map(
  //     (key, value) {
  //       final openAndCloseTimeAsList = _getOpenAndCloseTimeAsList(value);
  //       return MapEntry(
  //         key,
  //         _formatToOpenDashCloseTwelveHourTime(openAndCloseTimeAsList),
  //       );
  //     },
  //   );

  //   return mapToFormattedOpenAndCloseStrings;
  // }

  /// Takes in String parameter [dayHoursWithDash] of the format: "0800-1600" or [exclamationMark]
  ///
  /// If [dayHoursWithDash] equals [exclamationMark], the method returns null;
  /// else, it returns the two 24-hour time strings as a List.
  /// The first element of this list is the open time while the second is the closing time
  List<String>? _getOpenAndCloseTimeAsList(String dayHoursWithDash) {
    if (dayHoursWithDash == exclamationMark) {
      return null;
    } else {
      final List<String> openAndCloseTime = dayHoursWithDash.split("-");
      assert(openAndCloseTime.length == 2);
      return openAndCloseTime;
    }
  }

  /// Takes in a List containing the opening and closing time as 24-hour time strings and converts it to
  /// a "open-dash-close" 12-hour string.
  /// For example, [_formatToOpenDashCloseTwelveHourTime(["0800","1630"])] returns "8:00am - 4:30pm"
  ///
  /// Furthermore, it returns "Closed" if the [openAndCloseTimeAsList] equals null
  // String _formatToOpenDashCloseTwelveHourTime(
  //     List<String>? openAndCloseTimeAsList) {
  //   if (openAndCloseTimeAsList == null) {
  //     return "Closed";
  //   } else {
  //     assert(openAndCloseTimeAsList.length == 2);
  //     final String openTime =
  //         _convertToTwelveHourString(openAndCloseTimeAsList[0]);
  //     final String closeTime =
  //         _convertToTwelveHourString(openAndCloseTimeAsList[1]);
  //     return openTime + " - " + closeTime;
  //   }
  // }

  /// Takes in a 24hr time string and returns the 12hr format
  /// For example, [_convertToTwelveHourString("0800")] returns 8:00am, while
  /// [_convertToTwelveHourString("1630")] returns 4:30pm
  ///
  /// If the [removeZeroMinutes] parameter is set to true, the 12-hour time string
  /// is returned without the ":00"
  /// For example [convertToTwelveHourString("0800", removeZeroMinutes: true)] returns "8am"
  String _convertToTwelveHourString(
    String twentyFourHourString, {
    bool removeZeroMinutes = false,
  }) {
    assert(twentyFourHourString.length == 4);

    final String rawHour = twentyFourHourString.substring(0, 2);
    final String mins = twentyFourHourString.substring(2);
    final String meridien;

    int hourAsInt = int.parse(rawHour);
    meridien = (hourAsInt < 12) ? "am" : "pm";

    if (hourAsInt == 0) {
      hourAsInt = 12;
    } else if (hourAsInt > 12) {
      hourAsInt = hourAsInt - 12;
    }

    final String twelveHourString =
        hourAsInt.toString() + ":" + mins + meridien;

    return removeZeroMinutes
        ? twelveHourString.replaceFirst(":00", "")
        : twelveHourString;
  }

  /// The id for the foodspot that parents this [OperatingTimes] instance. This
  /// serves as a primary key
  final String foodSpotId;

  /// We declare this as a class property to ensure the same instance of the DateTime.now()
  /// is used throughout our program
  final DateTime dateTimeNow;

  /// These hold the json response strings as they are in the format:
  /// "0800-1600" or [exclamationMark] to show closed
  final String monHoursWithDash;
  final String tueHoursWithDash;
  final String wedHoursWithDash;
  final String thuHoursWithDash;
  final String friHoursWithDash;
  final String satHoursWithDash;
  final String sunHoursWithDash;

  static const exclamationMark = "!";
}
