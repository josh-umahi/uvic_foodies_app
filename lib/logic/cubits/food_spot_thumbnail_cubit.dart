import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/food_spot/food_spot_details.dart';
import '../../../data/repositories/food_spot_repository.dart';
import '../../data/models/enums.dart';
import 'overriden_date_cubit.dart';

part 'food_spot_thumbnail_state.dart';

class FoodSpotThumbnailsCubit extends Cubit<FoodSpotThumbnailsState> {
  /// Ensure to call the [init] method first when creating a new instance of this class!
  FoodSpotThumbnailsCubit() : super(const FoodSpotThumbnailsLoading());

  late final List<FoodSpotDetails> _allFoodSpotDetails = [];

  Future init() async {
    emit(const FoodSpotThumbnailsLoading());

    try {
      final foodSpotRepository = FoodSpotRepository();
      await foodSpotRepository.init();

      final _foodSpotFormattedResponses =
          foodSpotRepository.getFoodSpotFormattedResponses;

      for (var foodSpotFormattedResponse in _foodSpotFormattedResponses) {
        final foodSpotDetails = FoodSpotDetails.fromFormattedResponse(
          foodSpotFormattedResponse,
        );
        _allFoodSpotDetails.add(foodSpotDetails);
      }

      // Sorted by alphabetical order of "name" property
      _allFoodSpotDetails.sort((a, b) => a.name.compareTo(b.name));

      emit(FoodSpotThumbnailsLoaded(_allFoodSpotDetails));
    } catch (e) {
      emit(FoodSpotThumbnailsError(e));
    }
  }

  void filterByAll() {
    emit(FoodSpotThumbnailsLoaded(_allFoodSpotDetails));
  }

  void filterByOpenNow(OverridenDateCubit overridenDateCubit) {
    emit(const FoodSpotThumbnailsLoading());
    final filteredFoodSpotThumbnails =
        _allFoodSpotDetails.where((foodSpotThumbnail) {
      // * Here we must also ensure that the foodSpot is not overriden
      return foodSpotThumbnail.operatingTimes.isOpenNow &&
          !overridenDateCubit.shouldOverride(foodSpotThumbnail.id);
    }).toList();

    emit(FoodSpotThumbnailsLoaded(filteredFoodSpotThumbnails));
  }

  void filterByTheSub() {
    filterByBuildingFilterTag(BuildingFilterTag.TheSub);
  }

  void filterByMysticMarket() {
    filterByBuildingFilterTag(BuildingFilterTag.MysticMarket);
  }

  void filterByTheMod() {
    filterByBuildingFilterTag(BuildingFilterTag.TheMOD);
  }

  void filterByBuildingFilterTag(BuildingFilterTag buildingFilterTag) {
    emit(const FoodSpotThumbnailsLoading());
    final filteredFoodSpotThumbnails = _allFoodSpotDetails
        .where((foodSpotThumbnail) =>
            foodSpotThumbnail.buildingFilterTag == buildingFilterTag)
        .toList();
    emit(FoodSpotThumbnailsLoaded(filteredFoodSpotThumbnails));
  }
}
