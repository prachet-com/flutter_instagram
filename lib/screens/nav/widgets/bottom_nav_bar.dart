import 'package:flutter/material.dart';
import 'package:flutter_instagram/models/enums/bottom_nav_items.dart';

class BottomNavBar extends StatelessWidget {
  final Map<BottomNavItem, IconData> items;
  final BottomNavItem selectedItem;
  final Function(int) onTap;

  const BottomNavBar({
    Key key,
    @required this.items,
    @required this.selectedItem,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: BottomNavItem.values.indexOf(selectedItem),
      onTap: onTap,
      items: items.map(
        (item, icon) => MapEntry(
          item.toString(),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              icon,
              size: 30,
            ),
          ),
        ),
      ).values.toList(),
    );
  }
}
