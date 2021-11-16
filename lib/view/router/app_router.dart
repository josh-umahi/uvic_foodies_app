import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubits/food_spot_thumbnail_cubit.dart';
import '../../logic/cubits/overriden_date_cubit.dart';
import '../food_spots_listed/food_spots_listed.dart';

class AppRouter {
  final _foodSpotThumbnailsCubit = FoodSpotThumbnailsCubit()
    ..loadFoodSpotThumbnails();
  final _overridenDateCubit = OverridenDateCubit()..loadTodaysOverridenDate();

  Route generateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) {
      switch (settings.name) {
        case "/":
          return MultiBlocProvider(
            providers: [
              BlocProvider<OverridenDateCubit>.value(
                value: _overridenDateCubit,
              ),
              BlocProvider<FoodSpotThumbnailsCubit>.value(
                value: _foodSpotThumbnailsCubit,
              ),
            ],
            child: const FoodSpotsListedScreen(),
          );
        default:
          // TODO: Handle error route
          return Container();
      }
    });
  }

  dispose() {
    _foodSpotThumbnailsCubit.close();
    _overridenDateCubit.close();
  }
}
