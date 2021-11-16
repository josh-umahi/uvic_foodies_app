import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/food_spot/food_spot_thumbnail.dart';
import '../../../data/repositories/food_spot_repository.dart';
import '../../data/models/enums.dart';
import 'overriden_date_cubit.dart';

part 'food_spot_thumbnail_state.dart';

class FoodSpotThumbnailsCubit extends Cubit<FoodSpotThumbnailsState> {
  FoodSpotThumbnailsCubit() : super(FoodSpotThumbnailsLoading());

  List<FoodSpotThumbnail> _allFoodSpotThumbnails = [];

  Future<void> loadFoodSpotThumbnails() async {
    emit(const FoodSpotThumbnailsLoading());

    try {
      _allFoodSpotThumbnails =
          await FoodSpotRepository().getAllFoodSpotThumbnails();

      // Sorted by alphabetical order of "name" property
      _allFoodSpotThumbnails.sort((a, b) => a.name.compareTo(b.name));

      emit(FoodSpotThumbnailsLoaded(_allFoodSpotThumbnails));
    } catch (e) {
      emit(FoodSpotThumbnailsError(e));
    }
  }

  void filterByAll() {
    emit(FoodSpotThumbnailsLoaded(_allFoodSpotThumbnails));
  }

  void filterByOpenNow(OverridenDateCubit overridenDateCubit) {
    emit(const FoodSpotThumbnailsLoading());
    final filteredFoodSpotThumbnails =
        _allFoodSpotThumbnails.where((foodSpotThumbnail) {
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
    final filteredFoodSpotThumbnails = _allFoodSpotThumbnails
        .where((foodSpotThumbnail) =>
            foodSpotThumbnail.buildingFilterTag == buildingFilterTag)
        .toList();
    emit(FoodSpotThumbnailsLoaded(filteredFoodSpotThumbnails));
  }
}
