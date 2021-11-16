import 'package:flutter_test/flutter_test.dart';

import 'package:uvic_foodies_app/data/models/times_and_dates/operating_times.dart';
import 'package:uvic_foodies_app/data/repositories/overriden_dates_repository.dart';
import 'package:uvic_foodies_app/data/repositories/food_spot_repository.dart';

void main() {
  group("FoodSpotRepository: ", () {
    const foodSpotRepository = FoodSpotRepository();

    test("getAllFoodSpotThumbnails", () async {
      final foodSpotThumbnails =
          await foodSpotRepository.getAllFoodSpotThumbnails();
      print(foodSpotThumbnails);
    });

    test("getFoodSpotDetailsById", () async {
      final foodSpotDetails =
          await foodSpotRepository.getFoodSpotDetailsById("1");
      print(foodSpotDetails.toString());
    });

    test(
        "OperatingTimes.getAvailabilityStatusAndMessage method tested with different dateTime parameters",
        () async {
      final foodSpotDetails =
          await foodSpotRepository.getFoodSpotDetailsById("1");

      // TODO: Include testing with different dateTimes
      final dateTimeNow1 = DateTime(2021, 11, 8, 20, 0);
      final dateTimeNow2 = DateTime(2021, 11, 7, 19, 30);
      final dateTimeNow3 = DateTime(2021, 11, 8, 8, 0);

      print(foodSpotDetails.operatingTimes
          .getOpenAndCloseTimeOfDate(dateTimeNow1.weekday));
      print(foodSpotDetails.operatingTimes.availabilityStatus);
      print("\n");
    });
  });

  group("OverridenDatesRepository: ", () {
    const overridenDatesRepository = OverridenDatesRepository();

    test("getLastOverridenDate", () async {
      final overridenDates =
          await overridenDatesRepository.getLastOverridenDate();
      print(overridenDates);
    });
  });
}

void printAvailabilityStatusAndMessage(OperatingTimes operatingTimes) {
  print(
      "status: ${operatingTimes.availabilityStatus}, message: ${operatingTimes.availabilityMessage}");
}
