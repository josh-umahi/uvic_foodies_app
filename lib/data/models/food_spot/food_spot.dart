class FoodSpot {
  const FoodSpot({
    required this.id,
    required this.name,
    required this.coverImageUrl,
    required this.paymentsByFlexPlan,
    required this.paymentsByMealPlan,
    required this.mealOfferingsAsUrl,
    required this.mealOfferingsAsList,
    required this.locationPreposition,
    required this.locationNearbyLandmark,
    required this.buildingFilterTagString,
  });

  @override
  String toString() {
    return """
      id: $id
      name: $name
      coverImageUrl: $coverImageUrl
      locationPreposition: $locationPreposition
      locationNearbyLandmark: $locationNearbyLandmark
      buildingFilterTagString: $buildingFilterTagString
      paymentsByFlexPlan: $paymentsByFlexPlan
      paymentsByMealPlan: $paymentsByMealPlan
      mealOfferingsAsUrl: $mealOfferingsAsUrl
      mealOfferingsAsList: $mealOfferingsAsList
    """;
  }

  final String id;
  final String name;
  final String coverImageUrl;
  final bool paymentsByFlexPlan;
  final bool paymentsByMealPlan;

  /// Exactly one of these must be null
  final String? mealOfferingsAsUrl;
  final List<String>? mealOfferingsAsList;

  /// For example, locationPreposition = "in the" and locationNearbyLandmark = "Library".
  /// This may be used to give student a better description of where the foodspot is. They
  /// are separated in other to allow for different styling
  final String locationPreposition;
  final String locationNearbyLandmark;

  /// To enable filter-by-building for cases where one building houses multiple foodspots
  final String? buildingFilterTagString;
}
