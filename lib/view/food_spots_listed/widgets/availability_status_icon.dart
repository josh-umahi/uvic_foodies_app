import 'package:flutter/material.dart';

import '../../../data/models/enums.dart';

class AvailabilityStatusIcon extends StatelessWidget {
  const AvailabilityStatusIcon(this.availabilityStatus, {Key? key})
      : super(key: key);
  final AvailabilityStatus? availabilityStatus;

  @override
  Widget build(BuildContext context) {
    final IconData icon;
    final Color backgroundColor;

    switch (availabilityStatus) {
      case AvailabilityStatus.OpenNow:
        icon = Icons.check;
        backgroundColor = Color(0XFF2DB674);
        break;
      case AvailabilityStatus.ReOpensLaterToday:
        icon = Icons.clear_rounded;
        backgroundColor = Color(0XFFFFB118);
        break;
      case AvailabilityStatus.ReOpensAnotherDay:
        icon = Icons.clear_rounded;
        backgroundColor = Color(0XFFFF114A);
        break;
      default:
        // For overriden date scenario
        assert(availabilityStatus == null);
        icon = Icons.stop;
        backgroundColor = Color(0XFFFF114A);
        break;
    }

    return Container(
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      height: 20,
      width: 20,
      alignment: Alignment.center,
      child: Icon(icon, color: Colors.white, size: 15),
    );
  }
}
