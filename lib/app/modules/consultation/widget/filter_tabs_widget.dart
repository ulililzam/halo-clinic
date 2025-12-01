import 'package:flutter/material.dart';
import '../../../common/widgets/sliding_tabs_widget.dart';

class FilterTabsWidget extends StatelessWidget {
  final bool isOnlineSelected;
  final VoidCallback onOnlineTap;
  final VoidCallback onOfflineTap;

  const FilterTabsWidget({
    super.key,
    required this.isOnlineSelected,
    required this.onOnlineTap,
    required this.onOfflineTap,
  });

  @override
  Widget build(BuildContext context) {
    return SlidingTabsWidget(
      isFirstSelected: isOnlineSelected,
      firstLabel: 'Online',
      secondLabel: 'Offline',
      onFirstTap: onOnlineTap,
      onSecondTap: onOfflineTap,
      padding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
    );
  }
}
