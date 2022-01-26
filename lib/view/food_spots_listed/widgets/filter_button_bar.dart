import 'package:flutter/material.dart';

import '../constants.dart/enums.dart';
import 'filter_button.dart';

class FilterButtonBar extends StatefulWidget {
  const FilterButtonBar({
    Key? key,
  }) : super(key: key);

  @override
  _FilterButtonBarState createState() => _FilterButtonBarState();
}

class _FilterButtonBarState extends State<FilterButtonBar> {
  String selectedLabel = _filterList[0][0].toString();

  void handleItemSelected(String label) {
    setState(() {
      selectedLabel = label;
    });
  }

  static const _filterList = [
    ["All", FilterType.All],
    ["Open Now", FilterType.OpenNow],
    ["The Sub", FilterType.TheSub],
    ["The MOD", FilterType.TheMod],
    ["Mystic Market", FilterType.MysticMarket],
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: SizedBox(
        height: 34,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            const SizedBox(width: 16),
            ..._filterList.map(
              (filter) {
                // Assertion here is just for debugging
                assert(filter.length == 2);
                assert(filter[0] is String);
                assert(filter[1] is FilterType);

                return FilterButton(
                  label: filter[0].toString(),
                  filterType: filter[1] as FilterType,
                  selectedLabel: selectedLabel,
                  onTap: handleItemSelected,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
