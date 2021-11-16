part of 'food_spot_thumbnail_cubit.dart';

@immutable
abstract class FoodSpotThumbnailsState {
  const FoodSpotThumbnailsState();
}

class FoodSpotThumbnailsLoading extends FoodSpotThumbnailsState {
  const FoodSpotThumbnailsLoading();
}

class FoodSpotThumbnailsLoaded extends FoodSpotThumbnailsState {
  final List<FoodSpotThumbnail> foodSpotThumbnails;
  const FoodSpotThumbnailsLoaded(this.foodSpotThumbnails);
}

class FoodSpotThumbnailsError extends FoodSpotThumbnailsState {
  final dynamic error;
  FoodSpotThumbnailsError(this.error) {
    print(error);
  }
}
