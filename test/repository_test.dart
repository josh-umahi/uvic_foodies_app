import 'package:flutter_test/flutter_test.dart';
import 'package:uvic_foodies_app/data/repositories/food_spot_repository.dart';
import 'package:uvic_foodies_app/data/repositories/overriden_dates_repository.dart';

void main() {
  group("FoodSpotRepository: ", () {
    final foodSpotRepository = FoodSpotRepository();

    test("getMapOfIdsToImageUrls and getMapOfIdsToFormattedFoodSpots",
        () async {
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
      print("");
    });

    test("getFoodSpotById", () async {
      await foodSpotRepository.init();

      const idThatExists = "7H91XKUhCkJqDBRG4lzIzL";
      const idThatDoesntExists = "1H91XKUhCkJqDBRG4lzIzL";

      final foodSpot = foodSpotRepository.getFoodSpotById(
        idThatExists,
      );
      print(foodSpot);
      print("");
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
