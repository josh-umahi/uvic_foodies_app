import 'package:flutter_test/flutter_test.dart';
import 'package:uvic_foodies_app/data/models/food_spot/food_spot_details.dart';
import 'package:uvic_foodies_app/data/repositories/food_spot_repository.dart';
import 'package:uvic_foodies_app/data/repositories/overriden_dates_repository.dart';

void main() {
  group("FoodSpotRepository: ", () {
    final foodSpotRepository = FoodSpotRepository();

    test("getMapOfIdsToImageUrls and getFoodSpotFormattedResponses", () async {
      await foodSpotRepository.init();

      final mapOfIdsToImageUrls = foodSpotRepository.getMapOfIdsToImageUrls;
      final foodSpotFormattedResponses =
          foodSpotRepository.getFoodSpotFormattedResponses;

      assert(
        mapOfIdsToImageUrls.length == foodSpotFormattedResponses.length,
      );

      print("length of foodSpots: ${mapOfIdsToImageUrls.length}");
      print("");
    });

    test("Get a specific ", () async {
      await foodSpotRepository.init();

      const idThatExists = "7H91XKUhCkJqDBRG4lzIzL";

      final foodSpotFormattedResponse =
          foodSpotRepository.getFoodSpotFormattedResponses.firstWhere(
        (foodSpotFormattedResponse) =>
            foodSpotFormattedResponse.id == idThatExists,
      );

      final foodSpotDetails =
          FoodSpotDetails.fromFormattedResponse(foodSpotFormattedResponse);
      print(foodSpotDetails);
      print("");
    });

    test(
        "All formattedFoodSpots can successfully be coverted to foodSpotDetails",
        () async {
      await foodSpotRepository.init();

      final mapOfIdsToImageUrls = foodSpotRepository.getMapOfIdsToImageUrls;
      final foodSpotFormattedResponses =
          foodSpotRepository.getFoodSpotFormattedResponses;

      assert(
        mapOfIdsToImageUrls.length == foodSpotFormattedResponses.length,
      );

      for (var formattedFoodSpots in foodSpotFormattedResponses) {
        final foodSpotDetails =
            FoodSpotDetails.fromFormattedResponse(formattedFoodSpots);
        print(foodSpotDetails);
        print("********************************");
      }
    });
  });

  group("OverridenDatesRepository: ", () {
    const overridenDatesRepository = OverridenDatesRepository();

    test("getLastOverridenDate", () async {
      final overridenDates =
          await overridenDatesRepository.getLastOverridenDate();
      print(overridenDates);
      print("");
    });
  });
}
