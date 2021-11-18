import 'package:flutter_test/flutter_test.dart';

import 'package:uvic_foodies_app/data/models/times_and_dates/operating_times.dart';
import 'package:uvic_foodies_app/data/repositories/food_spot_repository.dart';

void main() {
  group("FoodSpotRepository: ", () {
    final foodSpotRepository = FoodSpotRepository();

    test("getAllFoodSpotsResponse", () async {
      await foodSpotRepository.init();

      final mapOfIdsToImageUrls = foodSpotRepository.getMapOfIdsToImageUrls;
      final mapOfIdsToFormattedFoodSpots =
          foodSpotRepository.getMapOfIdsToFormattedFoodSpots;

      print(mapOfIdsToImageUrls);
      print(mapOfIdsToFormattedFoodSpots);

      assert(
        mapOfIdsToImageUrls!.length == mapOfIdsToFormattedFoodSpots!.length,
      );

      print("length of foodSpots: ${mapOfIdsToImageUrls!.length}");
    });
  });
}

void printAvailabilityStatusAndMessage(OperatingTimes operatingTimes) {
  print(
      "status: ${operatingTimes.availabilityStatus}, message: ${operatingTimes.availabilityMessage}");
}
