import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/times_and_dates/overriden_date.dart';
import '../../data/repositories/overriden_dates_repository.dart';

class OverridenDateCubit extends Cubit<OverridenDate?> {
  OverridenDateCubit() : super(null);

  /// This method only loads an overriden date when one exists and the current
  /// DateTime.now() falls within it
  void loadTodaysOverridenDate() async {
    try {
      Future.delayed(Duration(seconds: 5));
      final overridenDate =
          await OverridenDatesRepository().getLastOverridenDate();

      if (overridenDate != null && overridenDate.todayIsOverriden) {
        emit(overridenDate);
      }
    } catch (e) {
      // TODO: proper error handling
      rethrow;
    }
  }

  bool shouldOverride(String foodSpotId) {
    if (state != null) {
      assert(state!.todayIsOverriden);
      return !(state!.idsToExclude.contains(foodSpotId));
    } else {
      return false;
    }
  }

  String get reasonForOverride {
    return state!.reasonForOverride;
  }
}
