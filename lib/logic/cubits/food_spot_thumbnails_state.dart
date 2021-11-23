part of 'food_spot_thumbnails_cubit.dart';

@immutable
abstract class FoodSpotThumbnailsState {
  const FoodSpotThumbnailsState();
}

class FoodSpotThumbnailsLoading extends FoodSpotThumbnailsState {
  const FoodSpotThumbnailsLoading();
}

class FoodSpotThumbnailsLoaded extends FoodSpotThumbnailsState {
  final List<FoodSpotDetails> foodSpotThumbnails;
  const FoodSpotThumbnailsLoaded(this.foodSpotThumbnails);
}

class FoodSpotThumbnailsError extends FoodSpotThumbnailsState {
  final dynamic error;
  FoodSpotThumbnailsError(this.error) {
    // TODO: Appropriate Exception Handling
    print(error);
  }
}
